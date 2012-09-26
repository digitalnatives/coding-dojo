require 'spec_helper'

describe Photo do
	context '#create' do
    context 'with base64 data' do
      let( :params ) {{
        :photo => 'R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==',
        :photo_file_name => 'small.gif',
        :photo_content_type => 'image/gif',
        :title => 'Title 1',
        :camera => 'Cannon EOS',
        :date => '2012-09-19',
        :author => 'Andris'
      }}
      subject { Photo.create_from_base64( params ) }

      its( :class ) { should == Photo }
      its( :persisted? ) { should be_true }
      its( :url ) { should_not be_blank }

      context 'with wrong arguments' do
        subject { Photo.create_from_base64( {} ) }
        it 'raises an error' do
          expect { subject }.to raise_error
        end
      end
    end

    context 'with url' do
      let( :params ) {{
        :photo_url => 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg',
        :title => 'Title 1',
        :camera => 'Cannon EOS',
        :date => '2012-09-19',
        :author => 'Csacsi'
      }}
      subject { Photo.create_from_url( params ) }

      its( :class ) { should == Photo }
      its( :persisted? ) { should be_true }
      its( :url ) { should_not be_blank }

      context 'downloading photo' do
        subject { Photo.new_from_url( params ) }
        it 'should call the download after create' do
          subject.should_receive( :download ).once
          subject.save
        end
      end

      context 'with wrong arguments' do
        subject { Photo.create_from_base64( {} ) }
        it 'raises an error' do
          expect { subject }.to raise_error
        end
      end
    end
  end
 
  context '#download' do
    subject { stub(:photo, id:1, photo_url:'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg') }
    it 'creates new downloadworker job' do
      expect {
        DownloadWorker.perform_async(subject.id, subject.photo_url)
      }.to change(DownloadWorker.jobs, :size).by(1)
    end
    
    context 'instance is invalid or Sidekiq is down' do
      subject { stub( :photo, :valid? => false ) }
      it 'raise an error' do
        expect { subject.download! }.to raise_error
      end
    end
  end

  context '#convert!' do
    context 'instance is valid' do
      subject { stub( :photo, :valid? => true, :path => '/image.jpg' ) }
      it 'puts the photo into Sidekiq worker' do
        expect {
          ConverterWorker.perform_async(subject.path)
        }.to change(ConverterWorker.jobs, :size).by(1)
      end
    end

    context 'instance is invalid or Sidekiq is down' do
      subject { stub( :photo, :valid? => false ) }
      it 'raise an error' do
        expect { subject.convert! }.to raise_error
      end
    end
  end
end

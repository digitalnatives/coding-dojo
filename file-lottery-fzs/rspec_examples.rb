# RSpec 2.0 syntax Cheet Sheet by http://ApproachE.com

# defining spec within a module will automatically pick Player::MovieList as a 'subject' (see below)
module Player
	describe MovieList, "with optional description" do
		  
	  it "is pending example, so that you can write ones quickly"
	  
	  it "is already working example that we want to suspend from failing temporarily" do
		pending("working on another feature that temporarily breaks this one")
		# actual test code is here, will never be reached
	  end
	  
	  it "is pending when failing" do
		  pending "This will be marked as pending when the block will fail, otherwise (on success) will fail telling 'Why am I pending if I pass?'" do
			  1.should == 2 # will mark example as pending
			  2.should == 2 # will fail asking to remove pending status of example
		  end
	  end
	  
	  # this will automatically generate name of the example based on the expectations inside it ~ 'it' with no description
	  specify { [1,2,3].should have(3).items }
	  
	  #any helper methods, before/after, modules etc declared in the outer group are available in the inner group.
	  describe "outer" do
		  before(:each) { puts "first" }
		  describe "inner" do
			before(:each) { puts "second" }
			it { puts "third"}
			after(:each) { puts "fourth" }
		  end
		  after(:each) { puts "fifth" }
	  end

	  # 'describe' and 'context' are equivalent
	  # I prefer to use 'context' for defining an 'environment'
	  context "when first created" do
		it "is empty" do
		  movie_list = MovieList.new
		  movie_list.should be_empty
		end
	  end

	  # I prefer to use 'describe' for nouns, verbs; defining a nested set of specifications
	  describe "forward" do
		it "should jump to a next movie" do
		  next_movie = MovieList.new(2).forward
		  next_movie.track_number.should == 2
		end
	  end
	end
	
	it "will have default subject that corresponds to the instance of first parameter in 'describe'" do
		subject.class.should be == MovieList
	end
	# unless subject is set explicitly
	subject { MovieList.new(10) } # approximately similar to 'before(:each)'
	# no need to use 'subject.should', use 'should'
	specify { should have(10).items } # same as below
	specify { subject.should have(10).items }
	

	# similar to specify { subject.track_number.should == 1}
	its(:track_number) { should == 1 }

	context "specs set-up" do
		# we can run setup before each examle, or all of them
		before(:each) do		
			@new_on_each_example = YourObject.new
		end
		before do
			@new_on_each_spec_less_verbose = YourObject.new
		end
		before(:all) do
			# Avoid using it as it will bring the 'shared state' into unit tests
			@same_instance_for_all_examples_within_the_context = YourObject.new
		end		
		it "can access attributes defined in 'before'" do
			@new_on_each_example.should_not be_nil
			@same_instance_for_all_examples_within_the_context.should_not be_nil
		end
		
		# cleanup code can be run the same way using 'after' instead of 'before'
		# Avoid using 'after'		
		# we can wrap examples: before + after + manual handling
		# In most cases 'before' + 'after' will work better.
		around do |example|			
			DB.transaction { example.run }
			# should handle errors manually, so do not do something like:
			# DB.start_transaction
			# example.run
			# DB.rollback_transaction
		end
		it "should run within a transaction" do
			MovieList.new.save!
		end		
		
		let(:new_on_each_example) { ObjectPerExample.new }
		it "can use method defined by 'let'" do
			new_on_each_example.should_not be_nil
			# the object is memoized, so
			new_on_each_example.should == new_on_each_example
		end
		
		# defining helper methods within context may be more useful than setup
		def forward(times) do
			list = MoviewList.new(10)
			list.forward(times).track_number
		end
		it "can use it multiple times" do
			forward(1).should == 1
			forward(2).should == 2
			forward(10).should == 1
		end
		
		# using 'yield' with helper methods
		def given_thing_with(options)
			yield Thing.new do |thing|
				thing.set_status(options[:status])
			end
		end
		it "should do something when ok" do
			given_thing_with(:status => 'ok') do |thing|
				thing.do_fancy_stuff(1, true, :move => 'left', :obstacles => nil)
			end
		end
		
		
		# helpers can come from modules
		module Helpers
			def shared_help
				[1,2,3]
			end
		end
		include Helpers
		it "can use helpers from Module" do
			shared_help.should == [1,2,3]
		end
		# or this module can be included for ALL example groups automatically during configuration:
		# RSpec.configure do |config|
		#	config.include Helpers
		# end
	end
	
	
	context "built-it stubbing, faking, mocking" do
		it "can stub" do
			source = double('source')			
			source.stub(:fetch) { [1,2,3,4,5] }			
			source.stub(:fetch_from).and_return([1,2]) # other way			
			MovieList.stub(:find).and_return(MovieList.new) # stub class method
			
			implementing = double('source')
			implementing.stub(:fetch) do |count|
				count == 5 ? [1,2,3] : [4,5,6,7] # provide stub logic here, easy to use for Fakes
			end			
			# easily stub chains of calls
			Blog.stub_chain(:posts, :published, :recent).and_return([1,2,3])
			Blog.posts.published.recent.should == [1,2,3]
		end
		it "can ignore non-expected method calls (NullObject pattern)" do
			source = double('source', :url => 'http://example.com').as_null_object			
			source.any_method_call_onwill_return_nil.should be_nil
			# the source mock object will record the 'any_method_call_onwill_return_nil' message internally though			
		end
		it "can set expectations" do
			source = double('source')
			# arguments
			source.should_receive(:fetch).with(10, "abc").and_return([1,2]) # expecting arguments (10, "abc") otherwise failing
			source.should_receive(:fetch).with(instance_of(Integer), "abc").and_return([1,2]) # don't care about 1st argument as long as it is Integer
			source.should_receive(:fetch).with(10, anything).and_return([1,2]) # don't care about 2nd argument at all
			source.should_receive(:fetch).with(any_args) # same as not using 'with' - don't care about arguments
			source.should_receive(:fetch).with(no_args) # 0 arguments, otherwise fail
			source.should_receive(:fetch).with(hash_including(:count => 10, :url => 'abc')) # arg should be Hash with all the values mentioned
			source.should_receive(:fetch).with(hash_not_including(:timeout => 5)) # arg should be Hash that contains no ':timout=>5'
			source.should_receive(:fetch).with(anything, /example/) # 2nd arg shuold match RegEx
			source.should_receive(:fetch).and_return([1], [1,2], [1,2,3]) # 1st call - [1], 2nd - [1,2], 3rd - [1,2,3], 4th - [1] and so on ...
			# expectation overrides stub
			source.stub(:fetch).and_return([1,2]) # will return [1,2] when called
			source.should_recieve(:fetch).and_return([3,4]) # prev been overriden and will return [3,4]
			# raising/throwing
			source.should_receive(:fetch).and_raise # raise Exception
			source.should_receive(:fetch).and_raise(ZeroDivisionError) # raise ZeroDivisionError
			source.should_receive(:fetch).and_raise(Exception.new('instance of aexception')) # raise given exception
			source.should_receive(:fetch).and_throw(:zero) # thro :zero					
			# order
			source.should_receive(:first).ordered # order matters in relation to others marked as ordered
			source.should_receive(:dosnt_matter) # don't care about order as long as it is called
			source.should_receive(:second).ordered # must be called after 'first'
			# order is not enforced across different objects:
			double('a').should_receive(:a).ordered # not related to the next one
			double('b').should_receive(:b).ordered # not related to the prev one
			# how many times?
			source.should_recieve(:fetch).exactly(1)times
			source.should_recieve(:fetch).at_most(5)times
			source.should_recieve(:fetch).at_least(2)times
			source.should_recieve(:fetch).twice
			source.should_recieve(:fetch).once
			# negative expectations
			source.should_recieve(:fetch).never
			source.should_recieve(:fetch).exactly(0)times
			source.should_not_recieve(:fetch)			
			
			
			list = MovieList.new(source)
			# if source.fetch has not been called, then example will fail
		end
		
		context "custom expectations" do
			# define custom expection class somewhere
			class GreaterThanMatcher
				def initialize(expected)
					@expected = expected
				end
				def description
					# will generate proper failure message and name of the example
					"a number greater than #{@expected}"
				end
				def ==(actual)
					# this will be called from
					actual > @expected
				end
			end
			
			# add this method to the RSpec (see set-up for global configuration)
			def greater_than(floor)
				GreaterThanMatcher.new(floor)
			end
			
			it "can be used in expectations" do
				subject.should_recieve(:forward).with(greater_than 3)
				subject.forward(5)
			end
		end # custom matchers
	end # mocking
	

	
	
	
	# set of same examples shared accross multiple specs
	# shared_examples_for should be in a separate file and defined outside of 'describe'/'context'
	shared_examples_for "any pizza" do
		it "tastes really good" do
			@pizza.should taste_really_good
		end
	end
	
	# to include the shared examples, into example groups:
	# it will assume @pizza instance variable is available here
	it_behaves_like "any pizza"
	
	context 'defining examples dynamically - everybody knows that :)' do
		{2 => 4, 3 => 6, 10 => 20}.each do |input, output|
			it "#{input} * 2 should be equal to #{output}" do
				(input * 2).should == output
				# will produce examples:
				# - 2 * 2 should be equal to 4
				# - 3 * 2 should be equal to 6
				# - 10 * 2 should be equal to 20
			end
		end
	end
	
	
	context "matchers" do
		it "shows built-in matchers" do
			# TODO: describe ===, eql, equal
			1.should == 1
			1.should_not == 2 # NOT 1.should != 2
			1.should_not equal(2) # same as above
			1.should_not == 2
			5.should be > 3
			5.should be <= 5
			(1.251).should be_close(1.25, 0.005)
			(1.251).should be_within(0.005).of 1.25 # >= RSpec 2.1
			"reg exp".should =~ /exp/
			[1,2].should include(1)
			1.should respond_to(:to_s)
			
			true.should be_true
			0.should be_true
			"this".should be_true
			
			lambda { Object.new.explodde! }.should raise_error(NameError)
			
			# nothing fits
			5.should satisfy { |it| it == 5 }
		end
		
		it "shows cool things" do
			count = 1
			expect {
				count = 3
			}.to change { count }.by(2)

			expect {
				# not changing
			}.to_not change { count }
			
			count = 1
			expect {
				count = 3
			}.to change { count }.to(3)
			
			count = 1
			expect {
				count = 3
			}.to change { count }from(1).to(3)
			
			# raise-rescue - exception handling
			expect {2 / 0}.to raise_error("divided by 0")
			expect {2 / 0}.to raise_error(/by 0/)
			expect {2 / 0}.to raise_error(ZeroDivisionError)
			
			# try-catch - expected circumstance handling
			lambda {  throw :room_is_full }.should throw_symbol(:room_is_full)
			
			# predicates
			nil.should be_nil #call nil.nil?
			[].should be_empty # calls [].empty?
			[1,2,3].should_not be_empty # calls [1,2,3].empty
			
			# convert anything that begins with have_ to a predicate on the target object beginning with has_
			{:id => 1}.has_key?(:id).should == true
			# can be written as
			{:id => 1}.should have_key(:id) # calls {:id => 1}.has_key?(:id)
			
			# collections			
			obj = {}
			def obj.numbers
			 [1,2,3,4]
			end
			
			obj.should have(4).numbers # calls obj.numbers.length
			[1,2,3,4].should have(4).items # 'items' is 'reserved' to say "ensure number of items on the collection"
			[1,2,3,4].should be_any {|n| n % 2 == 0} # [1,2,3,4].any? {|n| n %% 2 == 0}.should be_true
			"stringy".should have(7).charaters # same as items, just syntactic sugar
			[1,2,3,4].should have_exactly(24).items # same as 'have'
			obj.should have_at_least(3).numbers
			
			
		end
	end # built-in matchers
	
	
	
	
	
	context "custom matchers" do
		# TODO: describe multiple ways
		
		#define class
		class SimilarTo
			# mandatory - link to the object under test
			def initialize(it)
				# object under test
				@it = it
			end			
			# mandatory - check the positive condition
			def matches?(that)
				@that = that # save to use it in messages
				@that.to_s.downcase.should == @it.to_s.downcase
			end
			# optional - opoosite to mathch?
			def does_not_matche?(that)
				result = !matches?(that)
				@that, @it = @it, @that # swap for negative condition or additionally cusomtize messages
				result # don't forget to return
			end
			# mandatory
			def failure_message_for_should
				"expected #{@it} to be similar to #{@that}"
			end
			# optional
			def failure_message_for_should_not
				"expected #{@it} to be different from #{@that}"
			end
			#optional
			def description
				"#{@it} should be similar to #{@that}"
			end
		end
		
		#define method on example (see set-up to incude in all examples)
		def similar_to(that)
			SimilarTo.new(that)
		end
	end # custom matchers
	
	
	
	
	context "macros" do
		module ControllerMacros		
		  def should_render(template)
			it "should render the #{template} template" do
			  do_request
			  response.should render_template(template)
			end
		  end

		  def should_assign(hash)
			variable_name = hash.keys.first
			model, method = hash[variable_name]
			model_access_method = [model, method].join('.')
			it "should assign @#{variable_name} => #{model_access_method}" do
			  expected = "the value returned by #{model_access_method}"
			  model.should_receive(method).and_return(expected)
			  do_request
			  assigns[variable_name].should == expected
			end
		  end

		  def get(action)
			  define_method :do_request do
			    get action
			  end
  			yield
		  end
		end

		RSpec.configure do |config|
		  config.use_transactional_fixtures = true
		  config.use_instantiated_fixtures  = false
		  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
		  config.extend(ControllerMacros, :type => :controller)
		end		
	end # macros
	
end # module

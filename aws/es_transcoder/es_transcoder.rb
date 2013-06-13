require 'aws'

AWS.config({
  access_key_id: '...',
  secret_access_key: '...',
  region: "eu-west-1"
})

client = AWS::ElasticTranscoder::Client.new(region: "eu-west-1")

preset_id = "1371137166657-blyvol"
pipeline_id = "1370531954448-xew8hv"

job = client.create_job(
  pipeline_id: pipeline_id,
  output: {
    key: "output/output_#{Time.now.to_i}",
    preset_id: preset_id,
    thumbnail_pattern: "",
    rotate: "0"
  },
  input: {
    key: "input/tenyek_mindroom.flv",
    frame_rate: "auto",
    resolution: "auto",
    aspect_ratio: "auto",
    interlaced: "auto",
    container: "auto"
  }
)
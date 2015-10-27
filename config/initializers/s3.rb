CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAIXFKKUSF2QA35G3Q",
      :aws_secret_access_key  => "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",

  }
  config.fog_directory  = ENV["S3_BUCKET_NAME"]
end
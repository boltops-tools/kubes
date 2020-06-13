require "aws-sdk-ecr"

# require "aws_mfa_secure/ext/aws" # add MFA support

module Kubes
  module AwsServices
    extend Memoist

    def ecr
      Aws::ECR::Client.new
    end
    memoize :ecr
  end
end

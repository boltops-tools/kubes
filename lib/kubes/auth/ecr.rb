# Normally, you must authorized to AWS ECR to push to their registry with:
#
#   eval $(aws ecr get-login --no-include-email)
#
# If you haven't ever ran the ecr get-login command before then you'll get this error:
#
#   no basic auth credentials
#
# If you have ran it before but the auto token has expired you'll get this message:
#
#   denied: Your Authorization Token has expired. Please run 'aws ecr get-login' to fetch a new one.
#
# This class updates the ~/.docker/config.json file which is an internal docker file to automatically update the auto token for you.
# If that format changes, the update will need to be updated.
#
class Kubes::Auth
  class Ecr < Base
    include Kubes::AwsServices

    def run
      auth_token = fetch_auth_token
      if File.exist?(docker_config)
        data = JSON.load(IO.read(docker_config))
        data["auths"][@repo_domain] = {auth: auth_token}
      else
        data = {"auths" => {@repo_domain => {auth: auth_token}}}
      end

      # Handle legacy docker clients that still have old format with https://
      legacy_entry = "https://#{@repo_domain}"
      data["auths"][legacy_entry] = {auth: auth_token}

      ensure_dotdocker_exists
      IO.write(docker_config, JSON.pretty_generate(data))
    end

    def fetch_auth_token
      ecr.get_authorization_token.authorization_data.first.authorization_token
    end
  end
end

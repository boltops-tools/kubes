module Kubes::Docker::Strategy
  module Utils
    include Kubes::Logging
    include Kubes::Util::Sh
    include Kubes::Util::Time
    include Kubes::Docker::Strategy::ImageName
    include Kubes::Docker::Strategy::Hooks
  end
end

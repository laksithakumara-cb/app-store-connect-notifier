# frozen_string_literal: true

# Needed to load gems from Gemfile
require "rubygems"
require "bundler/setup"

require "spaceship"
require "json"

# Constants
def bundle_ids
  ENV["BUNDLE_IDENTIFIERS"] || "*"
end

def itc_username
  ENV["ITC_USERNAME"]
end

def itc_password
  ENV["ITC_PASSWORD"]
end

def spaceship_connect_api_key_id
  ENV["SPACESHIP_CONNECT_API_KEY_ID"]
end

def spaceship_connect_api_issuer_id
  ENV["SPACESHIP_CONNECT_API_ISSUER_ID"]
end

def spaceship_connect_api_key
  ENV["SPACESHIP_CONNECT_API_KEY"]
end

def authentication_method
  if !spaceship_connect_api_key_id.nil? && !spaceship_connect_api_issuer_id.nil? && !spaceship_connect_api_key.nil?
    return :token
  elsif !itc_username.nil? && !itc_password.nil?
    return :credentials
  end
end

def authenticate
  auth_method = authentication_method
  case auth_method
  when :token
    Spaceship::ConnectAPI.token = Spaceship::ConnectAPI::Token.create(
      key_id: spaceship_connect_api_key_id,
      issuer_id: spaceship_connect_api_issuer_id,
      filepath: spaceship_connect_api_key
    )
  when :credentials
    Spaceship::ConnectAPI.login(itc_username, itc_password)
  else
    raise "No valid authentication method found."
  end
rescue => e
  puts "Authentication failed: #{e.message}"
  exit 1
end

def itc_team_id_array
  # Split team_id
  env_teams = ENV["ITC_TEAM_IDS"]
  env_teams&.split(",") || []
end

def number_of_builds
  (ENV["NUMBER_OF_BUILDS"] || 1).to_i
end

def get_version_info(app)
  latest_version_info = app.get_latest_app_store_version(platform: Spaceship::ConnectAPI::Platform::IOS)
  icon_url = ""
  if latest_version_info.store_icon.present?
    icon_url = latest_version_info.store_icon.asset_token
  end
  {
    "name" => app.name,
    "version" => latest_version_info.version_string,
    "status" => latest_version_info.app_store_state,
    "appId" => app.id,
    "iconUrl" => icon_url
  }
end

def get_build_info(app)
  builds = app.get_builds.sort_by(&:uploaded_date).reverse[0, number_of_builds]

  builds.map do |build|
    {
      version: build.version,
      uploaded_data: build.uploaded_date,
      status: build.processing_state,
    }
  end
end

def get_app_version_from(bundle_ids)
  apps = []
  if bundle_ids != "*"
    bundle_ids.split(",").each do |id|
      app = Spaceship::ConnectAPI::App.find(id)
      apps.push(app) if app
    end
  else
    apps = Spaceship::ConnectAPI::App.all
  end
  apps.map do |app|
    info = get_version_info(app)
    info["builds"] = get_build_info(app)
    info
  end
end

authenticate

# All json data
versions = []

# Add for the team_ids
if itc_team_id_array.length.zero?
  versions += get_app_version_from(bundle_ids)
else
  itc_team_id_array.each do |itc_team_id|
    Spaceship::ConnectAPI.select_team(tunes_team_id: itc_team_id) if itc_team_id
    versions += get_app_version_from(bundle_ids)
  end
end

puts JSON.pretty_generate(versions)

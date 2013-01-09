# -*- coding: utf-8 -*-
namespace :kanna do
  config_path = File.join(Rails.root, 'config', 'kanna.yml')
  config = YAML.load(File.read(config_path))
  cordova_path = config["common"] && config["common"]["cordova_path"]
  if cordova_path.blank?
    puts "You have to specify cordova path at config/kanna.yml"
    abort
  end

  namespace :ios do
    app_name = Rails.application.class.name.split("::").first
    app_name_downcase = app_name.downcase

    ios_bin_path = File.join(cordova_path, 'lib', 'ios', 'bin')
    ios_create_command = File.join(ios_bin_path, 'create')
    ios_project_path = File.join(Rails.root, 'tmp', "#{app_name_downcase}-ios")

    desc "create ios project"
    task init: :environment do
      bundle_id = config["ios"] && config["ios"]["bundle_id"]
      if bundle_id.blank?
        puts "You have to specify bundle identifier for iOS application at config/kanna.yml"
        abort
      end
      command = "#{ios_create_command} #{ios_project_path} #{bundle_id} #{app_name}"
      puts "DO: #{command}"
      system command
    end

    ios_command_dir = File.join(ios_project_path, 'cordova')
    ios_build_command = File.join(ios_command_dir, 'build')
    ios_run_command = File.join(ios_command_dir, 'run')
    kanna_app_path = File.join(Rails.root, 'app', 'kanna')
    kanna_ios_path = File.join(kanna_app_path, 'ios')
    kanna_www_path = File.join(kanna_app_path, 'www')
    ios_config_path = File.join(ios_project_path, app_name)

    desc "build ios app"
    task build: :environment do
      cp_www_command = "cp -R #{kanna_www_path} #{ios_project_path}"
      cp_config_command = "cp #{kanna_ios_path}/* #{ios_config_path}"
      command = [cp_www_command, cp_config_command, ios_build_command, ios_run_command].join("; ")
      puts "DO: #{command}"
      system command
    end

    ios_app_path = File.join(ios_project_path, "build", "Release-iphonesimulator", "#{app_name}.app")
    ios_ipa_path = File.join(ios_project_path, "build", "ipa", "#{app_name}.ipa")

    desc "create ipa # mock"
    task release: :environment do
      command = "/usr/bin/xcrun -sdk iphoneos PackageApplication -v #{ios_app_path} -o #{ios_ipa_path}"
      puts "DO: #{command}"
      system command
    end

    desc "deploy testflight # mock"
    task deploy: :environment do
      # FIXME: トークンの設定
      testflight_api_token = "testflight_api_token"
      testflight_team_token = "testflight_team_token"
      notes = "notes"

      command = "/usr/bin/curl http://testflightapp.com/api/builds.json -F file=@\"#{ios_ipa_path}\" -F api_token='#{testflight_api_token}' -F team_token='#{testflight_team_token}' -F notes=\"#{notes}\" -F notify=True"
      puts "DO: #{command}"
    end
  end
end

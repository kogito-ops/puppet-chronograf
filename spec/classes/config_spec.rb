# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          service_defaults: '/etc/default/chronograf',
          service_definition: '/lib/systemd/system/chronograf.service',
          service_definition_template: 'chronograf/systemd.service.erb',
          resources_path: '/fubar/resources',
          user: 'foo',
          group: 'bar',
          host: '8.7.6.5',
          port: 8765,
          bolt_path: '/fubar/chronograf-v1.db',
          canned_path: '/fubar/canned',
          protoboards_path: '/fubar/protoboards',
          basepath: '/fubar/base',
          status_feed_url: 'https://www.influxdata.com/feed/json',
          default_host: 'UNSET',
          default_port: 'UNSET',
          default_tls_certificate: 'UNSET',
          default_token_secret: 'UNSET',
          default_log_level: 'UNSET',
          default_public_url: 'UNSET',
          default_generic_client_id: 'UNSET',
          default_generic_client_secret: 'UNSET',
          default_generic_auth_url: 'UNSET',
          default_generic_token_url: 'UNSET',
          default_use_id_token: 'UNSET',
          default_jwks_url: 'UNSET',
          default_generic_api_url: 'UNSET',
          default_generic_api_key: 'UNSET',
          default_generic_scopes: 'UNSET',
          default_generic_domains: 'UNSET',
          default_generic_name: 'UNSET',
          default_google_client_id: 'UNSET',
          default_google_client_secret: 'UNSET',
          default_google_domains: 'UNSET',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_file('/fubar/resources')
          .with(ensure: 'directory')
        should_not contain_augeas('set_default_log_level')
        should_not contain_augeas('default_generic_api_url')
        if facts[:os]['family'] == 'Debian'
          is_expected.to contain_file('/lib/systemd/system/chronograf.service')
            .with(ensure: 'present')
            .with_content(%r{User=foo})
            .with_content(%r{Group=bar})
            .with_content(%r{Environment=\"HOST=8.7.6.5\"})
            .with_content(%r{Environment=\"PORT=8765\"})
            .with_content(%r{Environment=\"BOLT_PATH=\/fubar\/chronograf-v1.db\"})
            .with_content(%r{Environment\="PROTOBOARDS_PATH=\/fubar\/protoboards\"})
            .with_content(%r{Environment=\"RESOURCES_PATH=\/fubar\/resources\"})
            .with_content(%r{ExecStart=\/usr\/bin\/chronograf \$CHRONOGRAF_OPTS})
        end
      end

      context 'on RedHat' do
        let :params do
          {
            service_defaults: '/etc/default/chronograf',
            service_definition: '/etc/systemd/system/chronograf.service',
            service_definition_template: 'chronograf/systemd.service.erb',
            resources_path: '/barfoot/resources',
            user: 'drill',
            group: 'sergeant',
            host: '5.4.3.2',
            port: 5432,
            bolt_path: '/barfoot/chronograf-v1.db',
            canned_path: '/barfoot/canned',
            protoboards_path: '/barfoot/protoboards',
            basepath: '/barfoot/chronograf/base',
            status_feed_url: 'https://www.influxdata.com/feed/json',
            default_host: 'UNSET',
            default_port: 'UNSET',
            default_tls_certificate: 'UNSET',
            default_token_secret: 'UNSET',
            default_log_level: 'UNSET',
            default_public_url: 'UNSET',
            default_generic_client_id: 'UNSET',
            default_generic_client_secret: 'UNSET',
            default_generic_auth_url: 'UNSET',
            default_generic_token_url: 'UNSET',
            default_use_id_token: 'UNSET',
            default_jwks_url: 'UNSET',
            default_generic_api_url: 'UNSET',
            default_generic_api_key: 'UNSET',
            default_generic_scopes: 'UNSET',
            default_generic_domains: 'UNSET',
            default_generic_name: 'UNSET',
            default_google_client_id: 'UNSET',
            default_google_client_secret: 'UNSET',
            default_google_domains: 'UNSET',
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_file('/etc/systemd/system/chronograf.service')
              .with(ensure: 'present')
              .with_content(%r{User=drill})
              .with_content(%r{Group=sergeant})
              .with_content(%r{Environment=\"HOST=5.4.3.2\"})
              .with_content(%r{Environment=\"PORT=5432\"})
              .with_content(%r{Environment=\"BOLT_PATH=\/barfoot\/chronograf-v1.db\"})
              .with_content(%r{Environment\="PROTOBOARDS_PATH=\/barfoot\/protoboards\"})
              .with_content(%r{Environment=\"RESOURCES_PATH=\/barfoot\/resources\"})
              .with_content(%r{ExecStart=\/usr\/bin\/chronograf \$CHRONOGRAF_OPTS})
          end
        end
      end

      context 'augeas' do
        let :params do
          {
            service_defaults: '/etc/default/chronograf',
            service_definition: '/lib/systemd/system/chronograf.service',
            service_definition_template: 'chronograf/systemd.service.erb',
            resources_path: '/fubar/resources',
            user: 'foo',
            group: 'bar',
            host: '8.7.6.5',
            port: 8765,
            bolt_path: '/fubar/chronograf-v1.db',
            canned_path: '/fubar/canned',
            protoboards_path: '/fubar/protoboards',
            basepath: '/fubar/base',
            status_feed_url: 'https://www.influxdata.com/feed/json',
            default_host: '1.2.1.2',
            default_port: 'UNSET',
            default_tls_certificate: 'UNSET',
            default_token_secret: 'UNSET',
            default_log_level: 'info',
            default_public_url: 'UNSET',
            default_generic_client_id: 'UNSET',
            default_generic_client_secret: 'UNSET',
            default_generic_auth_url: 'UNSET',
            default_generic_token_url: 'UNSET',
            default_use_id_token: 'UNSET',
            default_jwks_url: 'UNSET',
            default_generic_api_url: 'UNSET',
            default_generic_api_key: 'UNSET',
            default_generic_scopes: 'UNSET',
            default_generic_domains: 'UNSET',
            default_generic_name: 'UNSET',
            default_google_client_id: 'UNSET',
            default_google_client_secret: 'UNSET',
            default_google_domains: 'UNSET',
          }
        end
        it 'should have an augeas resource' do
          should contain_augeas('set_default_log_level')
          should contain_augeas('set_default_host')
        end
      end
    end
  end
end

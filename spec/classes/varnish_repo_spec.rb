require 'spec_helper'

describe 'varnish::repo', type: :class do
  let(:pre_condition) { 'include ::varnish' }

  context 'on a Debian OS' do
    let :facts do
      {
        osfamily: 'Debian',
        lsbdistid: 'Debian',
        operatingsystem: 'Debian',
        lsbdistcodename: 'foo',
      }
    end

    it { is_expected.to compile }
    it {
      is_expected.to contain_apt__source('varnish').with(
        'location'   => 'http://repo.varnish-cache.org/debian',
        'repos'      => 'varnish-3.0',
        'key'        => {
          'id'     => 'E98C6BBBA1CBC5C3EB2DF21C60E7C096C4DEFFEB',
          'source' => 'http://repo.varnish-cache.org/debian/GPG-key.txt',
        },
      )
    }
  end

  context 'on a RedHat OS' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        operatingsystemrelease: '6.4',
        architecture: 'x86_64',
      }
    end

    it { is_expected.to compile }
    it { is_expected.not_to contain_apt__source('varnish') }
    it {
      is_expected.to contain_yumrepo('varnish').with(
        'enabled' => '1',
        'baseurl' => 'http://repo.varnish-cache.org/redhat/varnish-3.0/el6/x86_64',
      )
    }
  end

  context 'on an Amazon OS' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'Amazon',
        operatingsystemrelease: '3.4.82-69.112.amzn1.x86_64',
        architecture: 'x86_64',
      }
    end

    it { is_expected.to compile }
    it { is_expected.not_to contain_apt__source('varnish') }
    it {
      is_expected.to contain_yumrepo('varnish').with(
        'enabled' => '1',
        'baseurl' => 'http://repo.varnish-cache.org/redhat/varnish-3.0/el6/x86_64',
      )
    }
  end
end

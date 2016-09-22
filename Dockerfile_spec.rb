require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir('.')
    #@container = Docker::Container.create(
    #  'Image' => @image.id
    #)

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, @image.id
  end

  it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  it "installs python interpreter" do
    expect(package("python3.4")).to be_installed
  end

  it "installs pip3" do
    expect(package("python3-pip")).to be_installed
  end

  it "installs wget package" do
    expect(package("wget")).to be_installed
  end

  it "intalls Foreign Function Interface library (libffi-dev)" do
    expect(package("libffi-dev")).to be_installed
  end

  it "installs Secured Socket Layer library (libssl)" do
    expect(package("libssl-dev")).to be_installed
  end

  it "installs python3-pyside package (errbot dependency)" do
    expect(package("python3-pyside")).to be_installed
  end

  it "installs git" do
    expect(package("git")).to be_installed
  end

  it "installs errbot using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/errbot")).to be_directory
  end

  it "installs sleekxmpp (xmpp errbot dependency) using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/sleekxmpp")).to be_directory
  end

  it "installs pyasn1 (errbot dependency) using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/pyasn1")).to be_directory
  end

  it "installs pyasn1 modules (errbot dependency) using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/pyasn1_modules")).to be_directory
  end

  it "installs slackclient (errbot dependency) using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/slackclient")).to be_directory
  end

  it "installs pytest (errbot dependency) using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/pytest.py")).to be_file
  end

  #it "installs errbot[IRC] using pip3" do
  #  expect(file("/usr/local/lib/python3.4/dist-packages/irc")). to be_directory
  #end

  #it "installs errbot[graphic] using pip3" do
  #end

  #it "installs errbot[hipchat] using pip3" do
  #  expect(file("/usr/local/lib/python3.4/dist-packages/hypchat")). to be_directory
  #end

  #it "installs errbot[telegram] using pip3" do
  #  expect(file("/usr/local/lib/python3.4/dist-packages/telegram")). to be_directory
  #end

  it "installs setuptools (errbot dependency) using pip3" do
    expect(file("/usr/local/lib/python3.4/dist-packages/setuptools")).to be_directory
  end

  it "creates folder for errbot plugin" do
    expect(file("/opt/spencer")).to be_directory
  end

  it "creates folder data for errbot plugin" do
    expect(file("/opt/spencer/data")).to be_directory
  end

  it "creates a config file for errbot plugin" do
    expect(file("/opt/spencer/config.py")).to be_file
  end

  it "add configuration to errbot config file" do
    expect(file("/opt/spencer/config.py")).to contain %Q{import logging
BACKEND = 'Slack'
BOT_DATA_DIR = r'/opt/spencer/data'
BOT_EXTRA_PLUGIN_DIR = '/opt/spencer/plugins'
BOT_LOG_FILE = r'/opt/spencer/errbot.log'
BOT_LOG_LEVEL = logging.DEBUG
BOT_IDENTITY = {
    'token' : 'xoxb-75459192881-6Bqjjjws25YnDVAv14yYVjoI',
}
BOT_ADMINS = ('@corpu', )}
  end

  def os_version
    command("lsb_release -a").stdout
  end

  after(:all) do
    #@container.kill
    #@image.remove
    #Got this error
    #An error occurred in an `after(:context)` hook.
    #Docker::Error::ConflictError: conflict: unable to delete 76a1f57e0d74 (cannot be forced) - image is being used by running container e36a6ae863fb
  end
end
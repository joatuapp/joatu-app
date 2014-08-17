# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'thor'
require 'childprocess'
require 'fileutils'

class Joatu < Thor
  desc "setup", "Sets up the app for development."
  def setup
    with_postgres do
      `bundle exec rake db:setup`
    end
  end

  protected

  def postgres_running?
    `ps aux | grep "postgres -D #{postgres_path}"`.split(/\r\n/).size > 1
  end

  def with_postgres(&block)
    if postgres_running?
      yield
    else
      postgres_proc = ChildProcess.build("foreman", "start", "db")
      postgres_proc.io.inherit!
      postgres_proc.start
      sleep(1)
      if postgres_proc.alive?
        yield
      end
      postgres_proc.stop
    end
  end

  def postgres_path
    File.expand_path("./vendor/postgresql")
  end
end

Joatu.start(ARGV)

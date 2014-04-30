# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'thor'
require 'childprocess'

class Joatu < Thor
  desc "setup", "Sets up the initial state of the database."
  def setup
    Dir.mkdir vendor_path unless Dir.exist? vendor_path
    if Dir.entries("#{vendor_path}/").join == "..."
      `pg_ctl init -D #{vendor_path}`
    end

    with_postgres do
      `bundle exec rake db:create`
      `bundle exec rake db:migrate`
    end
  end

  protected

  def postgres_running?
    `ps aux | grep "postgres -D #{vendor_path}"`.split(/\r\n/).size > 1
  end

  def with_postgres(&block)
    if postgres_running?
      yield
    else
      postgres_proc = ChildProcess.build("foreman", "start", "postgresql")
      postgres_proc.io.inherit!
      postgres_proc.start
      sleep(1)
      if postgres_proc.alive?
        yield
      end
      postgres_proc.stop
    end
  end

  def vendor_path
    File.expand_path("./vendor/postgresql")
  end
end

Joatu.start(ARGV)

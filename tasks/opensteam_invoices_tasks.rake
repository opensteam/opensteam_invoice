namespace :opensteam do
  namespace :plugins do
    namespace :invoice do

      desc "install the invoice plugin for opensteam (copy migration files..)"
      task :install do
        system "rsync -ruv vendor/plugins/opensteam_invoice/db/migrate db"
      end
    end
  end
end

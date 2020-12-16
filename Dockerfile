# FROM centos:7
FROM ruby:2.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /myapp
# rubyとrailsのバージョンを指定
#ENV ruby_ver="2.6.4"
#ENV rails_ver="5.1.4"

# 必要なパッケージをインストール
#RUN yum -y update
#RUN yum -y install epel-release
#RUN yum -y install git make autoconf curl wget
#RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2
#RUN yum clean all

# rubyとbundleをダウンロード
#RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
#RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# コマンドでrbenvが使えるように設定
#RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
#RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
#RUN echo 'eval "$(rbenv init --no-rehash -)"' >> /etc/profile.d/rbenv.sh

# rubyとrailsをインストール
# RUN source /etc/profile.d/rbenv.sh; rbenv install ${ruby_ver}; rbenv global ${ruby_ver}
# RUN source /etc/profile.d/rbenv.sh; gem update --system; gem install --version ${rails_ver} --no-ri --no-rdoc rails; gem install bundle

####################
# offical code add #
####################
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
# RUN gem install bundler -v 1.17.3
# RUN gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib

# # avoid error below.
# RUN bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
# RUN bundle install --path=vendor/bundle
# RUN bundle show | grep mysql2
# # avoid error :=> Could not find gem 'mysql2 (~> 0.5)' in any of the gem sources listed in your Gemfile.
# bundle version ERROR Avoid!!

# RUN gem update --system
RUN gem install bundler:2.2.1
# RUN gem install rails:6.0.0
# RUN rails webpacker:install
RUN bundle _2.2.1_ install 
#     && rails db:create \
#     && rails db:migrate
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

FROM centos:7

# rubyとrailsのバージョンを指定
#ENV ruby_ver="2.6.4"
#ENV rails_ver="5.1.4"

# 必要なパッケージをインストール
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git make autoconf curl wget
RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2
RUN yum clean all

# rubyとbundleをダウンロード
#RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
#RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# コマンドでrbenvが使えるように設定
#RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
#RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
#RUN echo 'eval "$(rbenv init --no-rehash -)"' >> /etc/profile.d/rbenv.sh

# rubyとrailsをインストール
#RUN source /etc/profile.d/rbenv.sh; rbenv install ${ruby_ver}; rbenv global ${ruby_ver}
#RUN source /etc/profile.d/rbenv.sh; gem update --system; gem install --version ${rails_ver} --no-ri --no-rdoc rails; gem install bundle


####################
# offical code add #
####################
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

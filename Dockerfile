FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install Yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get install yarn -y

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN mkdir /install
RUN touch Gemfile
RUN echo "source 'https://rubygems.org'" >> Gemfile
RUN echo "gem 'rails', '6.0.2'" >> Gemfile
WORKDIR /install
RUN bundle install
RUN mkdir /maya
WORKDIR /maya
COPY . /maya
RUN bundle install
ENV PATH="${PATH}:/root/.yarn/bin"
# RUN yarn install --check-files

EXPOSE 3000
RUN chmod +x ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]

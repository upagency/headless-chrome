FROM node:14

ENV CHROME_BIN /usr/bin/google-chrome-stable

RUN curl -qs https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
 sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

RUN apt-get update && \
  apt-get -qy install jq unzip google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

# Install chromedriver for Selenium
# we're trusting that the google chrome repo LATEST_RELEASE will sync with the google chrome stable
# version. This isn't actually verified
RUN CHROMEDRIVER_VERSION=$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE) &&\
  curl -o /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip && \
  unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
  chmod +x /usr/local/bin/chromedriver



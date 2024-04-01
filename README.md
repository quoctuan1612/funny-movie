# Introduction
This project is a Ruby on Rails application designed to share and enjoy videos. The main purpose of the project is to provide a platform where users can share and view videos.

## Features
- User Authentication: The application uses the Devise gem for user authentication. This allows users to sign up, log in, and log out.
- Video Sharing: Users can share videos with others. When a new video is shared, other logged-in users receive real-time notifications.
- Video Viewing: Users can view videos shared by others.

## Requirements
This code is written in Ruby and utilizes the Ruby on Rails framework. It requires the following software and tools to be installed:
- Ruby: Version 3.1.0
  - This version is specified in the Gemfile and Gemfile.lock.
- Rails: Version 7.0.8 or higher
  - This version is specified in the Gemfile.
- PostgreSQL: Required for Active Record
  - This is specified in the Gemfile.
- Node.js and npm: Installed in the Dockerfile
  - These are required for certain dependencies and build processes.
- Yarn: Installed in the Dockerfile
  - This is required for managing JavaScript packages.
- Bundler: Version 2.4.13
  - This version is specified in the Gemfile.lock and used in the setup script.
- Docker: Used to build the application
  - The Dockerfile specifies the necessary steps for building the application.

## Installation & Configuration
1. Install Docker
   ```shell
   Step 1: sudo apt update
   Step 2: sudo apt install apt-transport-https ca-certificates curl software-properties-common
   Step 3: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   Step 4: echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   Step 5: sudo apt update
   Step 6: sudo apt install docker-ce
   Step 7: sudo usermod -aG docker ${USER}
   Step 8: su - ${USER}
2. Clone the repository to your local machine
   ```shell
   git clone https://github.com/quoctuan1612/funny-movie
3. Navigate to the project directory
   ```shell
   cd funny-movie
4. Build and run the Docker containers with Docker Compose
   ```shell
   docker-compose build
## Database Setup
1. Create database
   ```shell
   docker-compose run --rm app bundle exec rails db:create
2. Migration
   ```shell
   docker-compose run --rm app bundle exec rails db:migrate
## Running the Application
1. Run unit test
   ```shell
   docker-compose up unit-tests
2. Run integration test
   ```shell
   docker-compose up integration-tests
3. Start server
   ```shell
   docker-compose up -d app
4. Access the application in a web browser
   ```shell
   localhost:3001
## Usage
## Troubleshooting
### Getting error ```/usr/bin/env: 'ruby\r': no such file or directory``` in Windows

1. If you already have checked out the code, the files are already indexed. After changing your Git settings, say by running:
   ```shell
   git config --global core.autocrlf input
2. You should refresh the indexes with
   ```shell
   git rm --cached -r .
3. And rewrite the Git index with
   ```shell
   git reset --hard

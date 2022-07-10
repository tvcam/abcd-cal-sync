# ABCD Cal Sync

Basic Rails application that let you sync and view your google calendar.

## Assumptions
With limited time, we made some assumptions in this application:
* User has only 5 calendars, so we only do one calendar import.
* User has only 20 events per calendars, so we only do 20 calendar events import at maximum.
* User has today calendar events.

## Setup

### Requirements
* Ruby 3.1.2
* Rails ~> 7.0.3
* sqlite3 ~> 1.4

### Google OAuth 2.0 and Calendar API
* We need to publish current google application or setup a new one and publish it. In development, a test google application is setup and ready to be used.
* Since development use test application, we need to add new test user to the application before he/she can use ABCD Cal Sync.
* To add new test user, please contact me via vibolteav@gmail.com, or create new application and add test user by yourself.

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

# Project 3 - Instagram

Instagram is a photo sharing app using Parse as its backend.

Time spent: 30 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling
- [x] Show the username and creation time for each post (in the Details View)
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen
- [x] User can like a post and see number of likes for each post in the post details screen
  - Is a little glitchy, did not have time to fine tune it, but it does update the count between the home and detail views.
- [x] Style the login page to look like the real Instagram login page
- [x] Style the feed to look like the real Instagram feed
- [ ] Implement a custom camera view

The following **additional** features are implemented:

- [x] Custom alerts when a user attempts to log in with one field empty or an improper account
- [x] Bio and username fields can also be changed in Edit Profile
- [x] A user can only input a certain character limit into a caption
- [x] Password secure entry on the Login page

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to include more complex data in databases e.g. what users have liked each post
2. Understanding the concepts of querying through Parse better.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://imgur.com/a/6XyXmLx

GIF created with [Kap](https://getkap.co/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- Parse
- Parse/UI
- SVDProgressHud

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2022] [Shreeya Indap]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

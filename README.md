# Social Scrolls

A social media app inspired by Facebook. Created as part of the Odin Project [curriculum](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project). View live page

OmniAuth is implemented for Facebook and Github. Active Storage is used for avatar and photo uploads, using cloud storage on . Action Mailer is used with the default [Mail](https://github.com/mikel/mail) gem.

User Signin is implemented with https://github.com/heartcombo/devise.

The test suite covers Models, Controllers, Mailers, and Integration Testing.

# Setting Up
```ruby
  $git clone git@github.com:Realmbird/odin-facebook.git 
```
# Thoughts

##### Models
<ol>
  <li> Setting up the friendship associations took me a while since I had to come up with a the name of what the relationship of a user recieving a friend request, after a few days the only name I could come up with was inverse_friendships</li>
  <li>
    I later added the ability to add friends and accept friend requests but, I wanted to make a option for the model to tell if the friendship was mutual on both sides. So I decided to make a boolean and used it to say if the friendship was mutual.
  </li>
</ol>
##### Devise
<ul>
  <li> Initial setup of Devise was not too difficult since I already had some experience setting up devise</li>
  <li> Trying to make db:seed data for the devise user model took me some time since I didn't know how to setup the devise models in active record association before.</li>
</ul>

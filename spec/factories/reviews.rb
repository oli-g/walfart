FactoryGirl.define do
  factory :review do
    product
    title       "love the xbox one."
    content     "ok, i bought this on black friday. yes the price is kind of steep at 499 plus games. but it was totally worth it. the set up takes like 30mins at most. With a big update to the system and kinect and gamertag setup. but after that your ready. On the dashboard they have tutorials on how to used your kinect with voice commands and etc. the kinect is awesome. they have free workout games that make you really sweat. The sensors are perfect and the voice recognition is quite cool. i love the lighting fast app switch where i can say xbox snap tv or netflix or any other app while making it splitscreen while playing games at the same time. or watching netflix while im in the que for bf4. or walking into my room and saying xbox on it turns on my t.v and stereo system in the process and also turns them off when i shut down my console or saying xbox off then confirming it. you can also connect your xbox 360 or hdmi for your cable on the the t.v port for the xbox one and enjoy it all on your xbox one. So far i love it and love the graphics of it. Battlfield 4 looks so pretty lol going to get ryse when it goes down cheaper. but soo far i love the xbox one and cant wait for the next games and apps for it"
    user        "TRUExSh0t"
    location    "san jose, CA"
    code        { Digest::MD5.hexdigest("#{title} - #{user} - #{location}") }
  end
end

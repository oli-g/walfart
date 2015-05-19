FactoryGirl.define do
  factory :product do
    name      "Xbox One Console + Kinect"
    price     "$498.00"
    url       "http://www.walmart.com/ip/Xbox-One-Console-Kinect/28876155"
    code      { Digest::MD5.hexdigest(url) }
  end
end

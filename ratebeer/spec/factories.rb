FactoryGirl.define do
	factory :user do
		username "Pekka"
		password "Secret1"
		password_confirmation "Secret1"
	end
	factory :rating do
		score 10
	end
	factory :rating2, class: Rating do
		score 20
	end
		factory :brewery do
			name "anonymous"
			year 1900
		end

		factory :beer do
			name "anonymous"
			brewery
			style_id 1
		end

		factory :style do
			style "Lager"
		end




end

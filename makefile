run: 
	flutter run -dart-define="DEBUG=true"

clean: 
	flutter clean 
	flutter pub get 

git: 
	git add . 
	git commit -m '$(m)'
	git push  
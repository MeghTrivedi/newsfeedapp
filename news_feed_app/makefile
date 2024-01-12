run: 
	flutter run 

clean: 
	flutter clean 
	flutter pub get 

git: 
	git add . 
	git commit -m '$(m)'
	git push  

android-apk: 
	$(FLUTTER) build apk 
	$(FLUTTER) install
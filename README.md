# Web scrapper

This CLI allow parse URLs by titles (by default)
![Screenshot from 2021-03-15 02-18-41](https://user-images.githubusercontent.com/12431839/111096219-115b3500-8550-11eb-81b4-850072e7c5ef.png)


# Getting Started
These instructions will get you a copy of the project up and running on your local machine:

1. Clone the repository:
```
   git clone https://github.com/ncr00t/web-scrapper
```
2. ```cd /web-scrapper```
3. ```bundle install```
4. Enter your URLs to urls argument (required arg) to next command: 
   
   ```ruby bin/scrapper.rb urls='https://github.com, https://google.com'```
5. Script will parse this URLs and print to results to terminal and generate csv file (history_date_time.csv).

Also can you see other script arguments using the command: ```ruby bin/scrapper.rb -h``` OR
                                                           ```ruby bin/scrapper.rb --helper```

# Testing

Just run in terminal ```rspec spec``` to run the tests.

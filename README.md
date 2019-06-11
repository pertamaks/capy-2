# capy-2
Belajar Capybara

setup environment dulu,
install cucumber, 
install bundler,

run bundle install/update dari direktori capy 2 untuk install gem yang diperlukan

untuk path capybara screenshot silahkan diganti dengan path direktori kalian

tambahkan ENV di runner yang ingin digunakan agar tidak perlu define default browser di sistem.
>> cucumber -p wip BROWSER=CHROME ENVI=LOCAL
list BROWSER yang tersedia ada di file env.rb dan list ENVI yang valid ada di hooks.rb

yang tidak jalan:
run script di emulator
run scenario pas play video di jenius (gak bisa exit) pakai emulation mobile chrome
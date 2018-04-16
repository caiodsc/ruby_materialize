#require_relative './config.rb'
m = gets.to_i
m+=1 unless m%2 == 0
n = gets.to_i
(m..n).step(2) {|i| p i }

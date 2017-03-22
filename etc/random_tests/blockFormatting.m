function blockFormatting

% Adding important libs
cd ../..
addP2Lib
cd etc/random_tests

a = '1.23';
b = '4.56';
c = '7.89';
from = { a b c }
to = fmap(@(x) replace_in_string(x, '.', ','), from);
to

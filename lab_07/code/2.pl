phonebook(ivanov, '111-11-11', address(moscow, lenina, 10, 15)).
phonebook(ivanov, '222-22-22', address(moscow, lenina, 10, 15)).
phonebook(ivanov, '333-33-33', address(minsk, baumana, 5, 14)).
phonebook(petrov, '444-44-44', address(moscow, pushkina, 1, 10)).
phonebook(sidorov, '555-55-55', address(yaroslavl, aviatorov, 100, 1)).

car(ivanov, toyota, black, 2500000, 'a111aa').
car(ivanov, lada, white, 800000, 'b222bb').
car(petrov, bmw, red, 4000000, 'c333cc').
car(sidorov, toyota, black, 2600000, 'o777oo').

owner(Brand, Color, Surname, City, Phone, Cost, Registration, Street, House, Flat) :-
    car(Surname, Brand, Color, Cost, Registration),
    phonebook(Surname, Phone, address(City, Street, House, Flat)).

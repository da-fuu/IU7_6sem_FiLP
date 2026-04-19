phonebook(ivanov, '111-11-11', address(moscow, lenina, 10, 15)).
phonebook(ivanov, '222-22-22', address(moscow, lenina, 10, 15)).

phonebook(ivanov, '333-33-33', address(kazan, baumana, 5, 42)).

phonebook(petrov, '444-44-44', address(moscow, pushkina, 1, 10)).

phonebook(sidorov, '555-55-55', address(spb, nevskiy, 100, 1)).

car(ivanov, toyota, black, 2500000, 'a111aa').
car(ivanov, lada, white, 800000, 'b222bb').

car(petrov, bmw, red, 4000000, 'c333cc').

car(sidorov, toyota, black, 2600000, 'o777oo').

find_owner(TargetBrand, TargetColor, Surname, City, Phone) :-
    car(Surname, TargetBrand, TargetColor, _, _),
    phonebook(Surname, Phone, address(City, _, _, _)).

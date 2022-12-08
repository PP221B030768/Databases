create or replace function next(a integer)
    returns integer
as
$$
begin
return a + 1;
end;
$$
language plpgsql;


select next(4);


create or replace function sum(a integer, b integer)
    returns integer
as
$$
begin
    return a + b;
end;
$$
    language plpgsql;


select sum(5, 12);


create or replace function divisible(a integer)
    returns bool
as
$$
begin
    if a % 2 = 0 THEN return true;
    else return false;
    end if;
end;
$$
    language plpgsql;


select divisible(4);
select divisible(5);


create or replace function password(password varchar)
    returns bool
as
$$
begin
    if password LIKE 'aa%' then return true;
    else return false;
    end if;
end;
$$
    language plpgsql;


select password('aab');
select password('1234');



create function pow(a numeric, out square numeric, out cube numeric) as
$$
begin
    square = a * a;
    cube = square * a;
end;
$$
    language plpgsql;


create function current()
    returns trigger as
$$
begin
    raise notice '%',now();
    return new;
end;
$$
    language plpgsql;

create trigger current_t before insert on table1 for each row execute procedure current();




create function age()
    returns trigger as
$$
begin
    raise notice '%', age(now(),new.t);
    return new;
end;
$$
    language plpgsql;

create trigger age_t before insert on table2 for each row execute procedure age();




create function tax()
    returns trigger as
$$
begin
    new.cost = new.cost * 1.12;
    return new;
end;
$$
    language plpgsql;

create trigger tax_t before insert on table3 for each row execute procedure tax();





create function stop()
    returns trigger as
$$
begin
    raise exception 'Deletion is not allowed';
end;
$$
    language plpgsql;

create trigger stop_t before delete on table4 execute procedure stop();





create function call()
    returns trigger as
$$
begin
    raise notice '%', validity(new.s);
    raise notice '%', pow(new.a);
    return new;
end;
$$
    language plpgsql;

create trigger call_t before insert on table5 for each row execute procedure call();


create table work(id int, name varchar, date_of_birth date, age int, salary numeric, workexperience int, discount numeric);





create function
    a(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
            salary = salary * 1.1;
        end loop;
    count = workexperience/5;
    for step in 1..count loop
            discount = discount * 1.01;
        end loop;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
    language plpgsql;



select * from a(1, 'a', '2000-03-02', 22, 1000, 10);




create or replace function
    b(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    if age >= 40 then salary = salary * 1.15;
    end if;
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
            salary = salary * 1.1;
        end loop;
    count = workexperience/5;
    for step in 1..count loop
            discount = discount * 1.01;
        end loop;
    if workexperience > 8 then salary = salary * 1.15;
    end if;
    if workexperience > 8 then discount = 20;
    end if;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
    language plpgsql;

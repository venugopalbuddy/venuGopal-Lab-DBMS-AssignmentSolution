/* 1)*/ create table supplier(supp_id int(3)primary key,supp_name varchar(255),supp_city varchar(255),supp_phone bigint);
       create table customer(cus_id int(3)primary key,cus_name varchar(255),cus_phone bigint,cus_city varchar(255),cus_gender varchar(9));
       create table category(cat_id int(3)primary key,cat_name varchar(255)); 
	   create table product(pro_id int(3)primary key,pro_name varchar(255),pro_desc varchar(255),cat_id int,foreign key(cat_id) references category(cat_id));
	   create table productdetails(prod_id int primary key,pro_id int,supp_id int,price double,foreign key(pro_id) references product(pro_id),foreign key(supp_id) references supplier(supp_id));
       create table orders(ord_id int primary key,ord_amount float,ord_date date,cus_id int,prod_id int,foreign key(cus_id) references customer(cus_id),foreign key(prod_id) references productdetails(prod_id));
	   create table rating(rat_id int primary key,cus_id int,supp_id int,rat_ratstars int,foreign key(cus_id) references customer(cus_id),foreign key(supp_id) references supplier(supp_id));
	   
/* 2)*/insert into supplier values(1,"rajesh retails","delhi",1234567890);
       insert into supplier values(2,"appario ltd.","mumbai",2589631470);
	   insert into supplier values(3,"knome products","bangalore",9785462315);
	   insert into supplier values(4,"bansal retails","kochi",8975463285);
	   insert into supplier values(5,"mittal ltd.","lucknow",7898456532);
	   
	   insert into customer values(1,"aakash",9999999999,"delhi","M");
	   insert into customer values(2,"aman",9785463215,"noida","M");
	   insert into customer values(3,"neha",9999999999,"mumbai","F");
	   insert into customer values(4,"megha",9994562399,"kolkata","F");
	   insert into customer values(5,"pulkit",7895999999,"lucknow","M");
	   
	   insert into category values(1,"books");
	   insert into category values(2,"games");
	   insert into category values(3,"groceries");
	   insert into category values(4,"electronics");
	   insert into category values(5,"clothes");
	   
	   insert into product values(1,"gta v","DFJDJFDJFDJFDJFJF",2);
	   insert into product values(2,"tshirt","DFDFJDFJDKFD",5);
	   insert into product values(3,"rog laptop","DFNTTNTNTERND",4);
	   insert into product values(4,"oats","REURENTBTOTH",3);
	   insert into product values(5,"harry potter","NBEMCTHTJTH",1);
	   
	   insert into productdetails values(1,1,2,1500);
	   insert into productdetails values(2,3,5,30000);
	   insert into productdetails values(3,5,1,3000);
	   insert into productdetails values(4,2,3,2500);
	   insert into productdetails values(5,4,1,1000);
	   
	   insert into orders values(20,1500,"2021-10-12",3,5);
	   insert into orders values(25,30500,"2021-09-16",5,2);
	   insert into orders values(26,2000,"2021-10-05",1,1);
	   insert into orders values(30,3500,"2021-08-16",4,3);
	   insert into orders values(50,2000,"2021-10-16",2,1);
	   
	   insert into rating values(1,2,2,4);
	   insert into rating values(2,3,4,3);
	   insert into rating values(3,5,1,5);
	   insert into rating values(4,1,3,2);
	   insert into rating values(5,4,5,4);
	   
/* 3)*/select c.cus_gender,count(*) as count from customer c inner join orders o on c.cus_id=o.cus_id where o.ord_amount>= 3000 group by c.cus_gender;

/* 4)*/select o.*,p.pro_name from orders o,product p,productdetails pd where o.cus_id=2 and o.prod_id=pd.prod_id and pd.pro_id=p.pro_id;

/* 5)*/select *from supplier where supp_id=(select supp_id from productdetails having count(supp_id)>1);

/* 6)*/select c.*from category c, product p,productdetails pd, orders o where c.cat_id=p.cat_id and pd.prod_id=o.prod_id having min(o.ord_amount);

/* 7)*/select p.pro_id,p.pro_name from product p,productdetails pd,orders o where pd.prod_id=o.prod_id and pd.pro_id=p.pro_id and o.ord_date>"2021-10-05";

/* 8)*/select cus_name,cus_gender from customer where cus_name like "%A%";

/* 9)*/ delimiter &&
     create procedure proc()
    -> begin
    -> select supplier.supp_id,supplier.supp_name,rating.rat_ratstars,
    -> case
    ->     when rating.rat_ratstars >4 then 'Genuine Supplier'
    ->     when rating.rat_ratstars >2 then 'Average Supplier'
    ->     else 'Supplier should not be considered'
    -> end as verdict from rating inner join supplier on supplier.supp_id=rating.supp_id;
    -> end &&
	delimiter ;
	
	call proc();
	

	

১. What is PostgreSQL?
PostgreSQL হলো একটি শক্তিশালী, ওপেন-সোর্স রিলেশনাল ডেটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি SQL ভাষার উপর ভিত্তি করে তৈরি এবং ACID (Atomicity, Consistency, Isolation, Durability) বৈশিষ্ট্য সমর্থন করে। এটি ডেটা সংরক্ষণ, পুনরুদ্ধার, বিশ্লেষণ এবং পরিচালনার জন্য ব্যবহৃত হয়।

➡ PostgreSQL এর কিছু বৈশিষ্ট্য:

জটিল কোয়েরি চালানো যায়

Custom functions ও stored procedures তৈরি করা যায়

JSON, XML, Hstore ইত্যাদি আধুনিক ডেটা টাইপ সমর্থন করে

ট্রানজ্যাকশন ব্যবস্থাপনা ও রোলব্যাক সাপোর্ট

SELECT * FROM students WHERE age > 18;
 ২. What is the purpose of a database schema in PostgreSQL?
স্কিমা (Schema) হলো ডেটাবেজের মধ্যে একটি যৌক্তিক কাঠামো বা সংগঠন, যা বিভিন্ন টেবিল, ভিউ, ফাংশন, এবং অন্যান্য অবজেক্ট-কে গ্রুপ করে।

➡ একটি ডেটাবেজে অনেকগুলো স্কিমা থাকতে পারে, এবং এগুলো একে অপরের থেকে আলাদা থাকে।

CREATE SCHEMA university;
CREATE TABLE university.students (...);
➡ এতে করে একাধিক টিম একই ডেটাবেজে কাজ করতে পারে নিজেদের স্কিমায়, অথচ সংঘর্ষ হয় না।

 ৩. Explain the Primary Key and Foreign Key concepts in PostgreSQL
Primary Key:

টেবিলের একটি কলাম (বা কলামগুলোর সমষ্টি) যা প্রতিটি রেকর্ডকে অন্যদের থেকে আলাদা করে।

এটি null হতে পারে না এবং দ্বৈত মান (duplicate) গ্রহণ করে না।


CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name TEXT
);
Foreign Key:

এটি একটি টেবিলের কলাম, যা অন্য টেবিলের primary key-কে নির্দেশ করে।

এটি দুইটি টেবিলের মধ্যে সম্পর্ক (relationship) তৈরি করে।

CREATE TABLE enrollments (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(student_id)
);
➡ এখানে student_id হলো একটি foreign key যেটি students টেবিলের primary key কে নির্দেশ করে।

 ৪. What is the difference between VARCHAR and CHAR data types?
বিষয়	VARCHAR	CHAR
মানের দৈর্ঘ্য	পরিবর্তনশীল (variable)	স্থির (fixed)
স্পেস	প্রয়োজনমতো জায়গা নেয়	অতিরিক্ত স্পেস রেখে পূর্ণ দৈর্ঘ্য ধরে রাখে
ব্যবহার	যখন বিভিন্ন দৈর্ঘ্যের স্ট্রিং প্রয়োজন	যখন সবগুলো মানের দৈর্ঘ্য সমান হবে

name VARCHAR(50)   -- নাম ৫০ অক্ষর পর্যন্ত হতে পারে
code CHAR(3)       -- সব কোডই ৩ অক্ষরের হবে, যেমন 'ABC'
➡ সাধারণত VARCHAR বেশি ব্যবহার হয় কারণ এটা মেমোরি অপচয় করে না।

৫. Explain the purpose of the WHERE clause in a SELECT statement
WHERE clause ব্যবহার হয় ডেটা ফিল্টার করার জন্য। এটি শর্ত দিয়ে নির্দিষ্ট রেকর্ডগুলো নির্বাচন করে।


SELECT * FROM students WHERE age > 18;
➡এখানে শুধুমাত্র ঐসব students কে দেখাবে যাদের বয়স ১৮ বছরের বেশি।

 ৬. What are the LIMIT and OFFSET clauses used for?
LIMIT: কতগুলো রেকর্ড রিটার্ন করবে তা নির্ধারণ করে।

OFFSET: কতগুলো রেকর্ড স্কিপ (উপেক্ষা) করবে তা নির্ধারণ করে।

Edit
SELECT * FROM students LIMIT 5 OFFSET 10;
➡ এখানে প্রথম ১০টি রেকর্ড উপেক্ষা করে পরবর্তী ৫টি রেকর্ড দেখাবে।
এটি সাধারণত pagination বা পাতায় পাতায় ডেটা দেখানোর জন্য ব্যবহৃত হয়।

৭. How can you modify data using UPDATE statements?
UPDATE কমান্ড দিয়ে টেবিলের বিদ্যমান ডেটা পরিবর্তন/আপডেট করা হয়।

UPDATE students SET age = 21 WHERE student_id = 5;
➡এখানে student_id যেটি ৫, তার বয়স আপডেট করে ২১ করা হলো।

 WHERE clause না দিলে, পুরো টেবিলের সব রেকর্ড আপডেট হয়ে যাবে — তাই সাবধান থাকতে হয়।

৮. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
JOIN ব্যবহার করা হয় একাধিক টেবিল থেকে সম্পর্কযুক্ত ডেটা একত্রে আনার জন্য।

➡ PostgreSQL-এ প্রচলিত JOIN-গুলো হলো:

INNER JOIN: শুধুমাত্র মিল থাকা রেকর্ডগুলো নেয়

LEFT JOIN: বাম টেবিলের সব রেকর্ড এবং মিল থাকলে ডান টেবিলের রেকর্ড নেয়

RIGHT JOIN: ডান টেবিলের সব রেকর্ড নেয়

FULL JOIN: উভয় টেবিলের সব রেকর্ড নেয়


SELECT students.name, enrollments.course
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id;
➡ এখানে দু’টি টেবিলের student_id এর মাধ্যমে সম্পর্ক তৈরি করা হয়েছে।

 ৯. Explain the GROUP BY clause and its role in aggregation operations
GROUP BY ব্যবহার হয় যখন আমরা একটি নির্দিষ্ট কলামের মান অনুযায়ী ডেটা গ্রুপ করতে চাই।

➡ এটি সাধারণত aggregate functions (COUNT, SUM, AVG, MAX, MIN) এর সাথে ব্যবহৃত হয়।


SELECT course, COUNT(*) FROM enrollments GROUP BY course;
➡ এখানে প্রতিটি কোর্সে কয়জন ভর্তি হয়েছে, তা দেখাবে।

🔷 ১০. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
Aggregate Functions হল ডেটার উপরে গণনা চালানোর ফাংশন।

COUNT() – কতটি রেকর্ড আছে

SUM() – মোট যোগফল

AVG() – গড় মান


```
SELECT COUNT(*) FROM students;
SELECT SUM(price) FROM products;
SELECT AVG(age) FROM students;
```

 এরা সাধারণত GROUP BY এর সাথে বা একা একাও ব্যবহার করা যায়।


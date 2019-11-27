


-- Sample data for eventtype table.
INSERT INTO eventtype VALUES ('42K', '42.2 Km Marathon');
INSERT INTO eventtype VALUES ('21K', '21.1 Km Half Marathon');
INSERT INTO eventtype VALUES ('10K', '10 Km Run');
INSERT INTO eventtype VALUES ('5K',  '5 Km Run');
INSERT INTO eventtype VALUES ('3K',  '3 Km Community Run/Walk');


-- Sample data for charity table.
INSERT INTO charity VALUES ('Cancer Council Of Victoria',	'Ms. Susan Madden',       '6140020002');
INSERT INTO charity VALUES ('Imagine',            			'Mr. John Lennon',        '6140040004');
INSERT INTO charity VALUES ('Lay Down Your Arms', 			'Ms. Bertha von Suttner', '6140060006');
INSERT INTO charity VALUES ('Heal the World',     			'Mr. Michael Jackson',    '6140080008');


-- Sample data for carnival table.
INSERT INTO carnival VALUES (to_date('6-May-2018','dd-Mon-yyyy'),  'RM Autumn Series Caulfield 2018', 'Mary Imparo', '900 Dandenong Rd, Caulfield, VIC, 3145');
INSERT INTO carnival VALUES (to_date('20-May-2018','dd-Mon-yyyy'), 'RM Autumn Series Clayton 2018',   'Mary Imparo', 'Scenic Blvd, Clayton, VIC, 3800');
INSERT INTO carnival VALUES (to_date('20-Aug-2018','dd-Mon-yyyy'), 'RM Winter Series Caulfield 2018', 'Mary Imparo', '900 Dandenong Rd, Caulfield, VIC, 3145');


-- Sample data for event table.
INSERT INTO event VALUES (to_date('6-May-2018','dd-Mon-yyyy'),  '42K');
INSERT INTO event VALUES (to_date('6-May-2018','dd-Mon-yyyy'),  '21K');
INSERT INTO event VALUES (to_date('6-May-2018','dd-Mon-yyyy'),  '10K');
INSERT INTO event VALUES (to_date('6-May-2018','dd-Mon-yyyy'),  '5K');
INSERT INTO event VALUES (to_date('6-May-2018','dd-Mon-yyyy'),  '3K');
INSERT INTO event VALUES (to_date('20-May-2018','dd-Mon-yyyy'), '42K');
INSERT INTO event VALUES (to_date('20-May-2018','dd-Mon-yyyy'), '21K');
INSERT INTO event VALUES (to_date('20-May-2018','dd-Mon-yyyy'), '10K');
INSERT INTO event VALUES (to_date('20-May-2018','dd-Mon-yyyy'), '5K');
INSERT INTO event VALUES (to_date('20-May-2018','dd-Mon-yyyy'), '3K');
INSERT INTO event VALUES (to_date('20-Aug-2018','dd-Mon-yyyy'), '5K');
INSERT INTO event VALUES (to_date('20-Aug-2018','dd-Mon-yyyy'), '3K');

COMMIT;

































































































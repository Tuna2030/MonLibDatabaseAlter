/*
    FIT9132 2018 Semester 1 Assignment 2 SOLUTIONS SCRIPT
    
    Student Name: Tuna REZAIAZAR
    
    Student ID: 29523095
    
	Studio Class: FIT9132 Studio 04 --------- 12:00pm - 14:00pm Tuesday
	
	Tutor: Shirin Ghaffarian Maghool
	
	Comments for your marker: Locationinfo is created for the task 4.2 and drop table command can be found in the task 1.2 as commented.
	
	

*/

-- ========================
-- Task 1 [15 + 5 = 20 mks]
-- ========================

-- Task 1.1
-- ===========
-- Add to your solutions script, the CREATE TABLE and CONSTRAINT definitions 
-- which are missing from the FIT9132_2018S1_A2_Schema_Start.sql script. You 
-- MUST use the relation and attribute names shown in the data model above to
-- name tables and attributes which you add.

CREATE TABLE entry (
    entryno           NUMBER(4) NOT NULL,
    carndate          DATE NOT NULL,
    entrystarttime    DATE,
    entryfinishtime   DATE,
    entryplace        NUMBER(4),
    charname          VARCHAR2(30),
    compno            NUMBER(4) NOT NULL,
    eventypecode      CHAR(3) NOT NULL,
    teamname          VARCHAR2(30)
);

COMMENT ON COLUMN entry.entryno IS 'Competitor entry number';
COMMENT ON COLUMN entry.carndate IS 'Carnival date';
COMMENT ON COLUMN entry.entrystarttime IS 'Entry start timing for the competitor';
COMMENT ON COLUMN entry.entryfinishtime IS 'Entry finish timing for the competitor';
COMMENT ON COLUMN entry.entryplace IS 'Entry placement according to start and finish time';
COMMENT ON COLUMN entry.charname IS 'Charity name that is supported';
COMMENT ON COLUMN entry.compno IS 'Competitor number';
COMMENT ON COLUMN entry.eventypecode IS 'Carnival event type';
COMMENT ON COLUMN entry.teamname IS 'Teamn name';

ALTER TABLE entry ADD CONSTRAINT entry_pk PRIMARY KEY ( entryno, carndate );

ALTER TABLE entry
ADD CONSTRAINT entry_carnival_un UNIQUE ( carndate, compno, eventypecode );

ALTER TABLE entry
ADD CONSTRAINT entry_carnival_fk FOREIGN KEY ( carndate )
REFERENCES carnival ( carndate );

ALTER TABLE entry
ADD CONSTRAINT entry_charity_fk FOREIGN KEY ( charname )
REFERENCES charity ( charname );

ALTER TABLE entry
ADD CONSTRAINT entry_competitor_fk FOREIGN KEY ( compno )
REFERENCES competitor ( compno );

ALTER TABLE entry
ADD CONSTRAINT entry_team_fk FOREIGN KEY ( teamname, carndate )
REFERENCES team ( teamname, carndate );

ALTER TABLE entry 
ADD CONSTRAINT entry_event_fk FOREIGN KEY ( carndate, eventypecode )
REFERENCES event ( carndate, eventypecode );

ALTER TABLE team ADD CONSTRAINT team_leader_un UNIQUE ( entryno, carndate );

ALTER TABLE team
ADD CONSTRAINT team_entry_fk FOREIGN KEY ( entryno, carndate )
REFERENCES entry ( entryno, carndate );

COMMIT;

    
-- Task 1.2
-- ===========
-- Add the full set of DROP TABLE statements to your solutions script.
-- In completing this section you must not use the CASCADE CONSTRAINTS clause 
-- as part of your DROP TABLE statement.

ALTER TABLE team DROP CONSTRAINT team_entry_fk;

DROP TABLE entry;

DROP TABLE event;

DROP TABLE eventtype;

DROP TABLE team;

DROP TABLE charity;

DROP TABLE carnival;

DROP TABLE competitor;

DROP TABLE emercontact;

DROP TABLE guardian;

--DROP TABLE locationinfo;
--Locationinfo table is created for task 4.2 which is a live database update. Uncomment the above command to drop the locationinfo table.

COMMIT;


-- ============================
-- Task 2 [10 + 1 + 1 = 12 mks]
-- ============================

-- Task 2.1
-- ===========
-- Add entries for the Rose family into the races for the carnival to be
-- held at Caulfield campus in Autumn season of 2018.
-- At this stage, Rose family is not supporting any charity and also not forming
-- a team. For competitor numbers, you may wish to assign primary keys that you
-- choose, provided the numbers are between 1000 and 1009. For these entries,
-- emergency contacts and guardians should be selected from within this family.

INSERT INTO emercontact VALUES ( '6112345678' , 'Fernando' , 'Rose' );
INSERT INTO emercontact VALUES ( '6187654321' , 'Adrianna' , 'Rose' );

INSERT INTO competitor VALUES ( 1000 , 'Fernando' , 'Rose' , 'M' , to_date('10/10/1970' , 'dd/mm/yyyy') , 'fernando@rm.org' , 'N' , '6112345678' , 'T' , '6187654321' , NULL );
INSERT INTO competitor VALUES ( 1001 , 'Adrianna' , 'Rose' , 'F' , to_date('11/11/1971' , 'dd/mm/yyyy') , 'adrianna@rm.org' , 'N' , '6187654321' , 'T' , '6112345678' , NULL );

INSERT INTO guardian VALUES ( '6112345678' , 'Fernando' , 'Rose' );
INSERT INTO guardian VALUES ( '6187654321' , 'Adrianna' , 'Rose' );

INSERT INTO competitor VALUES ( 1002 , 'Annamaria' , 'Rose' , 'F' , to_date('12/12/2004' , 'dd/mm/yyyy') , 'annamaria@rm.org' , 'Y' , '6187654322' , 'P' , '6187654321' , '6112345678' );
INSERT INTO competitor VALUES ( 1003 , 'Juan' , 'Rose' , 'M' , to_date('01/01/2006' , 'dd/mm/yyyy') , 'juan@rm.org' , 'Y' , '6112345679' , 'P' , '6112345678' , '6187654321' );

INSERT INTO entry VALUES ( 1 , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , NULL , NULL , NULL , NULL , 1000 , (SELECT eventypecode FROM eventtype WHERE eventypedesc = '21.1 Km Half Marathon') , NULL);
INSERT INTO entry VALUES ( 2 , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , NULL , NULL , NULL , NULL , 1001 , (SELECT eventypecode FROM eventtype WHERE eventypedesc = '21.1 Km Half Marathon') , NULL);
INSERT INTO entry VALUES ( 3 , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , NULL , NULL , NULL , NULL , 1002 , (SELECT eventypecode FROM eventtype WHERE eventypedesc = '3 Km Community Run/Walk') , NULL);
INSERT INTO entry VALUES ( 4 , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , NULL , NULL , NULL , NULL , 1003 , (SELECT eventypecode FROM eventtype WHERE eventypedesc = '3 Km Community Run/Walk') , NULL);

COMMIT;


-- Task 2.2
-- ===========
-- An Oracle sequence is to be implemented in the database for the subsequent
-- insertion of records into the database for COMPETITOR table. Provide the CREATE
-- SEQUENCE statement for COMPETITOR table. The sequence will be used to generate
-- new primary key values when adding new tuples/rows to the database. The sequence
-- should start at 1010 and increment by 1.

CREATE SEQUENCE competitor_seq START WITH 1010 INCREMENT BY 1;

COMMIT;

-- Task 2.3 
-- ===========
-- Provide the DROP SEQUENCE statement for the sequence objects you have created in
-- question 2.2 above.  

DROP SEQUENCE competitor_seq;

COMMIT;

-- ====================================
-- Task 3 [10 + 10 + 10 + 10  = 40 mks]
-- ====================================
-- Sequence created in task 2 must be used to insert data into the database for the 
-- task 3 questions. For these questions you may only use the data supplied in this task.

-- Task 3.1
-- ===========
-- Add an entry for the following competitors, who are friends and studying at Monash
-- University, into the races to be held at Caulfield campus in Autumn season of 2018.
-- Both of them have nominated their friend Forrest Gump with the phone number 6142800800
-- to be their emergency contact person.

INSERT INTO emercontact VALUES ( '6142800800' , 'Forrest' , 'Gump' );

INSERT INTO competitor VALUES ( COMPETITOR_SEQ.NEXTVAL , 'Wendy' , 'Wang' , 'F' , to_date('14/09/1985' , 'dd/mm/yyyy') , 'wendy@rm.org' , 'Y' , '6112349876' , 'F' , '6142800800' , NULL );
INSERT INTO competitor VALUES ( COMPETITOR_SEQ.NEXTVAL , 'Sam' , q'{O'Hare}' , 'M' , to_date('08/08/1986' , 'dd/mm/yyyy') , 'sam@rm.org' , 'Y' , '6198761234' , 'F' , '6142800800' , NULL );

INSERT INTO entry VALUES ( (SELECT MAX(ENTRYNO) FROM ENTRY)+1 , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , NULL , NULL , NULL , NULL , (SELECT compno FROM competitor WHERE compfname = 'Wendy' AND compphone = '6112349876') , (SELECT eventypecode FROM eventtype WHERE eventypedesc = '42.2 Km Marathon') , NULL);
INSERT INTO entry VALUES ( (SELECT MAX(ENTRYNO) FROM ENTRY)+1 , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , NULL , NULL , NULL , NULL , (SELECT compno FROM competitor WHERE compfname = 'Sam' AND compphone = '6198761234') , (SELECT eventypecode FROM eventtype WHERE eventypedesc = '42.2 Km Marathon') , NULL);

COMMIT;

-- Task 3.2
-- ===========
-- Sometime after the registration, Wendy has decided to form a team for 42.2 Km marathon
-- event and call the team Gentle Earth. She will be the leader of this newly created team.
-- Wendy would also like her team to support Cancer Council Of Victoria charity. Add this
-- information into the database.

INSERT INTO team VALUES ( 'Gentle Earth' , (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%') , 1 , 'Cancer Council Of Victoria' , (SELECT entryno FROM entry WHERE compno = (SELECT compno FROM competitor WHERE compfname = 'Wendy' AND compphone = '6112349876')));
UPDATE entry SET teamname = 'Gentle Earth', CHARNAME = 'Cancer Council Of Victoria' WHERE entryno = (SELECT entryno FROM entry WHERE compno = (SELECT compno FROM competitor WHERE compfname = 'Wendy' AND compphone = '6112349876'));

COMMIT;

-- Task 3.3
-- ===========
-- Sometime after Wendy setup the Gentle Earth team and the team is registered with Run
-- Monash, Sam O'Hare decides to join the Gentle Earth team for 42.2 Km marathon event. 

UPDATE entry SET teamname = 'Gentle Earth', CHARNAME = 'Cancer Council Of Victoria' WHERE entryno = (SELECT entryno FROM entry WHERE compno = (SELECT compno FROM competitor WHERE compfname = 'Sam' AND compphone = '6198761234'));
UPDATE team SET TEAMNOMEMBERS = 2 WHERE TEAMNAME = 'Gentle Earth' AND CARNDATE = (SELECT carndate FROM carnival WHERE carnname LIKE '%Autumn%' AND carnname LIKE '%Caulfield%' AND carnname LIKE '%2018%');

COMMIT;

-- Task 3.4
-- ===========
-- Suppose today is 6th of May 2018 and Wendy and Sam have already completed their race and
-- they were the only courageous ones to run the marathon for cancer research on a wet day.
-- Update the database to record these completions. You can use your imagination for the attribute
-- values of the rows you need to update. However, you need to ensure that the data is meaningful
-- to the case study. 

UPDATE entry SET ENTRYSTARTTIME = to_date('06/05/2018 8:30:00', 'dd/mm/yyyy HH24:MI:SS'), ENTRYFINISHTIME = to_date('06/05/2018 17:30:00', 'dd/mm/yyyy HH24:MI:SS'), ENTRYPLACE = 1 WHERE entryno = (SELECT entryno FROM entry WHERE compno = (SELECT compno FROM competitor WHERE compfname = 'Wendy' AND compphone = '6112349876'));
UPDATE entry SET ENTRYSTARTTIME = to_date('06/05/2018 8:30:00', 'dd/mm/yyyy HH24:MI:SS'), ENTRYFINISHTIME = to_date('06/05/2018 17:35:00', 'dd/mm/yyyy HH24:MI:SS'), ENTRYPLACE = 2 WHERE entryno = (SELECT entryno FROM entry WHERE compno = (SELECT compno FROM competitor WHERE compfname = 'Sam' AND compphone = '6198761234'));

COMMIT;


-- ============================
-- Task 4 [8 + 20  = 28 mks]
-- ============================

-- Task 4.1
-- ===========
-- record whether all competitors have any medical issues. They do not want to keep the
-- details of the medical condition. They only want to flag whether a competitor has a medical
-- issue or not (the value cannot be left empty). Change the "live" database and add this required
-- information for all competitors currently in the database. You may assume that all existing
-- competitors will be recorded as NOT having a medical condition. The information will be updated
-- later when the competitors reply to their request for this additional information. 

ALTER TABLE competitor add medical_issue VARCHAR2(1);
COMMENT ON COLUMN competitor.medical_issue IS 'If competitor has medical issue ''Y'' if not ''N'' for the input';
UPDATE competitor SET MEDICAL_ISSUE = 'N' WHERE MEDICAL_ISSUE IS NULL;
ALTER TABLE competitor ADD CONSTRAINT check_medical_issue CHECK ( medical_issue IN ( 'Y' , 'N' ) );
ALTER TABLE competitor MODIFY medical_issue NOT NULL;

COMMIT;


-- Sometime after sending the request to all the existing competitors for this additional information, 
-- Wendy Wang has contacted Run Monash and indicated that she has a medical condition. Update the database
-- to reflect this new information.

UPDATE competitor SET MEDICAL_ISSUE='Y' WHERE COMPFNAME='Wendy' AND COMPPHONE='6112349876';

COMMIT;

-- Task 4.2
-- ===========
-- 4.2 record the type of track (Grass or Synthetic), total number of parking spaces and the type of
-- toilets available at each location (Portable, Fixed or Mixed) since they are receiving a lot of
-- calls for this information from participants. Change the "live" database and add this information
-- into the database in a manner that changes made are most appropriate and consistent and data is
-- reasonable and correct to help Run Monash retrieve this information effectively from the database.

CREATE TABLE locationinfo (
    loc_id           NUMBER(4) NOT NULL,
    carnlocation     VARCHAR2(50) NOT NULL,
    track_type       VARCHAR2(9),
    toilets          VARCHAR2(8),
    parking_space    NUMBER(4)
);

COMMENT ON COLUMN locationinfo.loc_id IS 'Primary key for the locationinfo table';
COMMENT ON COLUMN locationinfo.carnlocation IS 'Carnival location';
COMMENT ON COLUMN locationinfo.track_type IS 'Track type of the location';
COMMENT ON COLUMN locationinfo.toilets IS 'Toilet type of the location';
COMMENT ON COLUMN locationinfo.parking_space IS 'Number of parking spaces in the location';

ALTER TABLE locationinfo ADD CONSTRAINT location_pk PRIMARY KEY ( loc_id );

ALTER TABLE locationinfo ADD CONSTRAINT check_track_type CHECK ( track_type IN ( 'Grass' , 'Synthetic' ) );
ALTER TABLE locationinfo ADD CONSTRAINT check_toilets CHECK ( toilets IN ( 'Portable' , 'Fixed' , 'Mixed' ) );

INSERT INTO locationinfo VALUES(1 , '900 Dandenong Rd, Caulfield, VIC, 3145' , 'Grass' , 'Portable' , 200);
INSERT INTO locationinfo VALUES(2 , 'Scenic Blvd, Clayton, VIC, 3800' , 'Synthetic' , 'Mixed' , 400);

ALTER TABLE carnival add loc_id NUMBER(4);
UPDATE carnival SET carnival.loc_id = (SELECT loc_id FROM locationinfo WHERE carnival.carnlocation = locationinfo.carnlocation);
ALTER TABLE carnival ADD CONSTRAINT location_carnival_fk FOREIGN KEY ( loc_id ) REFERENCES locationinfo ( loc_id );

COMMIT;


--========================= End of FIT9132_2018S1_A2_Solutions.sql ==================================

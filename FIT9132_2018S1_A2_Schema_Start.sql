-- RunMonash Schema


CREATE TABLE carnival (
    carndate       DATE NOT NULL,
    carnname       VARCHAR2(50) NOT NULL,
    carndirector   VARCHAR2(50) NOT NULL,
    carnlocation   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN carnival.carndate IS
    'Date of carnival ';

COMMENT ON COLUMN carnival.carnname IS
    'Carnival name';

COMMENT ON COLUMN carnival.carndirector IS
    'Carnival director''s name';

COMMENT ON COLUMN carnival.carnlocation IS
    'Carnival''s location';

ALTER TABLE carnival ADD CONSTRAINT carnival_pk PRIMARY KEY ( carndate );

CREATE TABLE charity (
    charname      VARCHAR2(30) NOT NULL,
    charcontact   VARCHAR2(50) NOT NULL,
    charphone     CHAR(10) NOT NULL
);

COMMENT ON COLUMN charity.charname IS
    'Approved charity name';

COMMENT ON COLUMN charity.charcontact IS
    'Charity contact person name';

COMMENT ON COLUMN charity.charphone IS
    'Charity phone number';

ALTER TABLE charity ADD CONSTRAINT charity_pk PRIMARY KEY ( charname );

CREATE TABLE competitor (
    compno           NUMBER(4) NOT NULL,
    compfname        VARCHAR2(30) NOT NULL,
    complname        VARCHAR2(30) NOT NULL,
    compgender       CHAR(1) NOT NULL,
    compdob          DATE NOT NULL,
    compemail        VARCHAR2(50) NOT NULL,
    compuniopt       CHAR(1) NOT NULL,
    compphone        CHAR(10) NOT NULL,
    compecrelation   CHAR(1) NOT NULL,
    emerconphone     CHAR(10) NOT NULL,
    guardphone       CHAR(10)
);

ALTER TABLE competitor
    ADD CONSTRAINT check_compgender CHECK ( compgender IN (
        'M',
        'F'
    ) );

ALTER TABLE competitor
    ADD CONSTRAINT check_uniopt CHECK ( compuniopt IN (
        'Y',
        'N'
    ) );

ALTER TABLE competitor
    ADD CONSTRAINT check_ecrelation CHECK ( compecrelation IN (
        'P',
        'T',
        'G',
        'F'
    ) );

COMMENT ON COLUMN competitor.compno IS
    'Competitor registration number';

COMMENT ON COLUMN competitor.compfname IS
    'Competitor first name';

COMMENT ON COLUMN competitor.complname IS
    'Competitor last name';

COMMENT ON COLUMN competitor.compgender IS
    'Competitor gender (M or F)';

COMMENT ON COLUMN competitor.compdob IS
    'Competitpr date of birth';

COMMENT ON COLUMN competitor.compemail IS
    'Competitor email address';

COMMENT ON COLUMN competitor.compuniopt IS
    'Competitor university student status (''Y'' or ''N'')';

COMMENT ON COLUMN competitor.compphone IS
    'Competitor phone number';

COMMENT ON COLUMN competitor.compecrelation IS
    'Emergency contact relationship to competitor(P or  T or G or F)
P = Parent
T = Partner
G = Guardian
F = Friend
';

COMMENT ON COLUMN competitor.emerconphone IS
    'Emergency contact phone number';

COMMENT ON COLUMN competitor.guardphone IS
    'Guardian''s contact number';

ALTER TABLE competitor ADD CONSTRAINT competitor_pk PRIMARY KEY ( compno );

CREATE TABLE emercontact (
    emerconphone   CHAR(10) NOT NULL,
    emerconfname   VARCHAR2(30) NOT NULL,
    emerconlname   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN emercontact.emerconphone IS
    'Emergency contact phone number';

COMMENT ON COLUMN emercontact.emerconfname IS
    'Emergency Contact First Name';

COMMENT ON COLUMN emercontact.emerconlname IS
    'Emergency Contact Last Name';

ALTER TABLE emercontact ADD CONSTRAINT emercontact_pk PRIMARY KEY ( emerconphone );


CREATE TABLE event (
    carndate       DATE NOT NULL,
    eventypecode   CHAR(3) NOT NULL
);

COMMENT ON COLUMN event.carndate IS
    'Date of carnival (unique identifier)';

COMMENT ON COLUMN event.eventypecode IS
    'Event type, reflects the distance of the event, e.g 10K is for 10 kilometer ';

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY ( carndate,
                                                        eventypecode );

CREATE TABLE eventtype (
    eventypecode   CHAR(3) NOT NULL,
    eventypedesc   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN eventtype.eventypecode IS
    'Even type, reflects the distance of the event, e.g 10K is for 10 kilometer ';

COMMENT ON COLUMN eventtype.eventypedesc IS
    'Even type description';

ALTER TABLE eventtype ADD CONSTRAINT eventtype_pk PRIMARY KEY ( eventypecode );

CREATE TABLE guardian (
    guardphone   CHAR(10) NOT NULL,
    guardfname   VARCHAR2(30) NOT NULL,
    guardlname   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN guardian.guardphone IS
    'Guardian''s contact number';

COMMENT ON COLUMN guardian.guardfname IS
    'Guardian''s first name';

COMMENT ON COLUMN guardian.guardlname IS
    'Guardian Last Name';

ALTER TABLE guardian ADD CONSTRAINT guardian_pk PRIMARY KEY ( guardphone );

CREATE TABLE team (
    teamname        VARCHAR2(30) NOT NULL,
    carndate        DATE NOT NULL,
    teamnomembers   NUMBER(2) NOT NULL,
    charname        VARCHAR2(30),
    entryno         NUMBER(4) NOT NULL
);

COMMENT ON COLUMN team.teamname IS
    'Team name';

COMMENT ON COLUMN team.carndate IS
    'Date of carnival';

COMMENT ON COLUMN team.teamnomembers IS
    'Number of team members';

COMMENT ON COLUMN team.charname IS
    'Approved charity name';

COMMENT ON COLUMN team.entryno IS
    'Team leader for this team in this carnival';

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( teamname,
                                                      carndate );

ALTER TABLE competitor
    ADD CONSTRAINT competitor_emercontact_fk FOREIGN KEY ( emerconphone )
        REFERENCES emercontact ( emerconphone );

ALTER TABLE competitor
    ADD CONSTRAINT competitor_guardian_fk FOREIGN KEY ( guardphone )
        REFERENCES guardian ( guardphone );

ALTER TABLE event
    ADD CONSTRAINT event_carnival_fk FOREIGN KEY ( carndate )
        REFERENCES carnival ( carndate );

ALTER TABLE event
    ADD CONSTRAINT event_eventtype_fk FOREIGN KEY ( eventypecode )
        REFERENCES eventtype ( eventypecode );

ALTER TABLE team
    ADD CONSTRAINT team_carnival_fk FOREIGN KEY ( carndate )
        REFERENCES carnival ( carndate );

ALTER TABLE team
    ADD CONSTRAINT team_charity_fk FOREIGN KEY ( charname )
        REFERENCES charity ( charname );

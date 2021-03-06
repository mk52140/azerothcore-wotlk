-- DB update 2017_02_03_00 -> 2017_02_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_00 2017_02_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1485367936523741798'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1485367936523741798');
DELETE FROM `disables` WHERE `entry`= 45425;
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(0, 45425, 64, '', '', 'Ignore LOS for Shoot (Dummy)');
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

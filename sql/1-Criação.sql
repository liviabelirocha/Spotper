CREATE DATABASE Spotper ON 

PRIMARY (
    NAME = 'SpotPer',
    FILENAME = 'C:\FBD\SpotPer.mdf',
    SIZE = 5120KB,
    FILEGROWTH = 1024KB
),

FILEGROUP SpotPer_Sec (
    NAME = 'SpotPer_Sec_Arq_1',
    FILENAME = 'C:\FBD\SpotPer_Sec_001.ndf',
    SIZE = 1024KB,
    FILEGROWTH = 30%
),
(
    NAME = 'SpotPer_Sec_Arq_2',
    FILENAME = 'C:\FBD\SpotPer_Sec_002.ndf',
    SIZE = 1024KB,
    MAXSIZE = 3072KB,
    FILEGROWTH = 15%
),

FILEGROUP SpotPer_Terc (
    NAME = 'SpotPer_Terc',
    FILENAME = 'C:\FBD\SpotPer_Terc.ndf',
    SIZE = 2048KB,
    MAXSIZE = 5120KB,
    FILEGROWTH = 1024KB
)

LOG ON (
    NAME = 'SpotPer_Log',
    FILENAME = 'C:\FBD\SpotPer_log.ldf',
    SIZE = 1024KB,
    FILEGROWTH = 10%
);
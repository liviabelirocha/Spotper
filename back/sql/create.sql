CREATE DATABASE db_Spotper ON PRIMARY (
    NAME = 'SpotPer',
    FILENAME = '',
    SIZE = 5120KB,
    FILEGROWTH = 1024KB
),

FILEGROUP SpotPet_Sec (
    NAME = 'SpotPer_Sec_Arq_1',
    FILENAME = '',
    SIZE = 1024KB,
    FILEGROWTH = 30%
),
(
    NAME = 'SpotPer_Sec_Arq_2',
    FILENAME = '',
    SIZE = 1024KB,
    MAXSIZE = 3072KB,
    FILEGROWTH = 15%
),

FILEGROUP SpotPer_Terc (
    NAME = 'SpotPer_Terc',
    FILENAME = '',
    SIZE = 2048KB,
    MAXSIZE = 5120KB,
    FILEGROWTH = 1024KB
)

LOG ON (
    NAME = 'SpotPer_Log',
    FILENAME = '',
    SIZE = 1024KB,
    FILEGROWTH = 10%
);
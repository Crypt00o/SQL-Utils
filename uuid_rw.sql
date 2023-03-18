
-- author : Eslam Muhammed Elabd ( 0xCrypt00o )
-- email : octopus2672001@gmail.com
-- github : https://github.com/Crypt00o
-- support me on 
-- bitcoin address : bc1qdp3f6u3puwkyu6ztxz7hzcurd7jnjyw6hzjcas

-- description : declaration of UUID_TO_BIN , BIN_TO_UUID functions useing ( MYSQL / MARIADB ) syntax to support
--				 storing uuid as bin with 16 byte (128 bit like postgresql instead of 36 byte (2288 bit)


-- UUID_TO_BIN ( uuid VARCHAR(36) ) return BINARY(16)  of uuid with size of 16 byte 
-- recommand useing it while store uuid , or update a uuid value to new uuid value

CREATE FUNCTION IF NOT EXISTS UUID_TO_BIN(uuid VARCHAR(36)) RETURNS BINARY(16)
BEGIN
      DECLARE result BINARY(16);
      SET result = (SELECT UNHEX(REPLACE(uuid,'-','')) AS uuid_bin);
      RETURN result;
END;

-- BIN_TO_UUID( uuid_encoded BINARY(16) ) return VARCHAR(36) return uuid human readable with a size of 36 byte 
-- recommand useing it while searching with a value of human readable uuid in binary encoded uuid

CREATE FUNCTION IF NOT EXISTS BIN_TO_UUID(uuid_encoded BINARY(16)) RETURNS VARCHAR(36)
BEGIN
      DECLARE result VARCHAR(36);
      SET result = (SELECT 
          LOWER(
               CONCAT(
                        SUBSTR(HEX(uuid_encoded), 1, 8), '-',
                        SUBSTR(HEX(uuid_encoded), 9, 4), '-',
                        SUBSTR(HEX(uuid_encoded), 13, 4), '-',
                        SUBSTR(HEX(uuid_encoded), 17, 4), '-',
                        SUBSTR(HEX(uuid_encoded), 21, 12)
               )) AS uuid_decoded);
      RETURN result;
END;


# cx_Oracle fix for python, connect to Oracle XE /opt/conda/envs/glados/lib/python3.6/site-packages/django/db/backends/oracle/base.py
 
 
    def __init__(self, connection):
        self.cursor = connection.cursor()
        # Necessary to retrieve decimal values without rounding error.
        self.cursor.numbersAsStrings = True
        self.cursor.outputtypehandler = self._output_type_handler
        # Default arraysize of 1 is highly sub-optimal.
        self.cursor.arraysize = 100
        # https://github.com/django/django/commit/d52577b62b3138674807ac74251fab7faed48331

    @staticmethod
    def _output_type_handler(cursor, name, defaultType, length, precision, scale):
        """
        Called for each db column fetched from cursors. Return numbers as
        strings so that decimal values don't have rounding error.
        """
        if defaultType == Database.NUMBER:
            return cursor.var(
                Database.STRING,
                size=255,
                arraysize=cursor.arraysize,
                outconverter=str,
            )
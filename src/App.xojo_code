#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Break
		End Function
	#tag EndEvent


End Class
#tag EndClass

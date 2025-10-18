#tag Class
Protected Class Session
Inherits WebSession
#tag Session
  interruptmessage=
  disconnectmessage=
  confirmmessage=
  AllowTabOrderWrap=False
  ColorMode=0
  SendEventsInBatches=True
#tag EndSession
	#tag Event
		Sub RequestedData(key As String, value As String)
		  Select Case key
		  Case "current_map"
		    Try
		      Var decodedHex As MemoryBlock = DecodeHex(value)
		      Var serializedMap As String = decodedHex.Decompress
		      Map = MUD.Map.FromJSON(New JSONItem(serializedMap))
		      If Session.CurrentPage IsA MapWebPage Then
		        MapWebPage(Session.CurrentPage).Refresh
		      End If
		    Catch ex As JSONException
		      Map = New MUD.Map
		      Return
		    End Try
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Break
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub RequestMapFromBrowser()
		  RequestData("current_map")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveMap()
		  If Session.Map <> Nil Then
		    Var serializedMap As MemoryBlock = Session.Map.ToJSON.ToString
		    Var compressedMap As String = EncodeHex(serializedMap.Compress(MemoryBlock.CompressionLevels.Best))
		    Session.RecordData("current_map", compressedMap)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Map As MUD.Map
	#tag EndProperty


	#tag Constant, Name = kExampleInput, Type = String, Dynamic = False, Default = \"{\n  \"islands\": [\n    {\n      \"id\": \"mainIsland\"\x2C\n      \"name\": \"Isla Principal\"\x2C\n      \"zones\": [\n        {\n          \"id\": \"startZone\"\x2C\n          \"type\": \"pvp\"\x2C\n          \"name\": \"Zona de Inicio\"\x2C\n          \"rooms\": [\n            {\n              \"id\": \"startingRoom\"\x2C\n              \"name\": \"Plaza Central\"\x2C\n              \"description\": \"Te encuentras en la Plaza Central de la Isla Principal\x2C un lugar donde los aventureros inician su viaje. Los adoquines est\xC3\xA1n desgastados por el paso del tiempo\x2C y una fuente en el centro emite un suave murmullo de agua. Es un refugio seguro para quienes reci\xC3\xA9n comienzan su traves\xC3\xADa\x2C pero el peligro nunca est\xC3\xA1 demasiado lejos...\"\x2C\n              \"x\": 0\x2C\n              \"y\": 0\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"north\": \"marketRoom\"\x2C\n                \"east\": \"trainingGrounds\"\x2C\n                \"south\": \"townHall\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"tutorialNPC\"\n                }\n              ]\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"bandit\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"marketRoom\"\x2C\n              \"name\": \"Mercado\"\x2C\n              \"description\": \"El bullicio del mercado te rodea\x2C un mar de voces que negocian\x2C regatean y ofrecen los mejores productos de la isla. Comerciantes y artesanos muestran con orgullo sus mercanc\xC3\xADas\x2C desde espadas relucientes hasta ex\xC3\xB3ticas especias. El olor a pan reci\xC3\xA9n horneado y el humo de los puestos de carne a la parrilla llenan el aire\"\x2C\n              \"x\": 0\x2C\n              \"y\": 1\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"south\": \"startingRoom\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"merchantNPC\"\x2C\n                  \"name\": \"Comerciante\"\x2C\n                  \"dialogues\": {\n                    \"welcome\": \"\xC2\xA1Bienvenido a mi tienda! \xC2\xBFQu\xC3\xA9 te gustar\xC3\xADa comprar\?\"\x2C\n                    \"farewell\": \"\xC2\xA1Vuelve pronto!\"\n                  }\n                }\n              ]\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"bandit\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"trainingGrounds\"\x2C\n              \"name\": \"Campos de Entrenamiento\"\x2C\n              \"description\": \"Aqu\xC3\xAD\x2C los j\xC3\xB3venes aventureros se enfrentan a mu\xC3\xB1ecos de pr\xC3\xA1ctica y se desaf\xC3\xADan en duelos amistosos. El sonido de las espadas chocando y las \xC3\xB3rdenes de los instructores resuenan en el aire. Es el lugar ideal para afilar tus habilidades antes de aventurarte m\xC3\xA1s all\xC3\xA1 de los confines seguros de la Isla Principal\"\x2C\n              \"x\": 1\x2C\n              \"y\": 0\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"west\": \"startingRoom\"\x2C\n                \"east\": \"wildMeadow\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"trainerNPC\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"wildMeadow\"\x2C\n              \"name\": \"Prado Silvestre\"\x2C\n              \"description\": \"Ante ti se extiende un prado vasto y colorido\x2C cubierto de flores silvestres que se mecen suavemente con la brisa. El sol ba\xC3\xB1a la escena en tonos dorados\x2C y el dulce aroma de las flores llena el aire. Aqu\xC3\xAD\x2C la paz es tangible\x2C pero cuidado: la calma puede ser enga\xC3\xB1osa\"\x2C\n              \"x\": 2\x2C\n              \"y\": 0\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"west\": \"trainingGrounds\"\x2C\n                \"east\": \"harborEntrance\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"items\": [\n                {\n                  \"id\": \"wildFlower\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"townHall\"\x2C\n              \"name\": \"Ayuntamiento\"\x2C\n              \"description\": \"El Ayuntamiento se alza como un edificio robusto y solemne en el coraz\xC3\xB3n de la isla. Las paredes de piedra cuentan historias de decisiones pasadas y destinos sellados. Aqu\xC3\xAD se re\xC3\xBAnen los l\xC3\xADderes y se traman los planes que moldean el futuro de la isla\"\x2C\n              \"x\": 0\x2C\n              \"y\": -1\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"north\": \"startingRoom\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"mayorNPC\"\n                }\n              ]\n            }\n          ]\n        }\x2C\n        {\n          \"id\": \"harborZone\"\x2C\n          \"name\": \"Puerto\"\x2C\n          \"type\": \"pve\"\x2C\n          \"rooms\": [\n            {\n              \"id\": \"harborEntrance\"\x2C\n              \"name\": \"Entrada del Puerto\"\x2C\n              \"description\": \"La entrada al puerto siempre est\xC3\xA1 llena de actividad. Pescadores\x2C marineros y mercaderes se mueven con urgencia\x2C cargando cajas y bultos. El olor a sal y pescado fresco es fuerte\x2C y los gritos de los estibadores a\xC3\xB1aden un toque de caos a la atm\xC3\xB3sfera\"\x2C\n              \"x\": 3\x2C\n              \"y\": 0\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"west\": \"wildMeadow\"\x2C\n                \"east\": \"docks\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"harborGuardNPC\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"docks\"\x2C\n              \"name\": \"Muelles\"\x2C\n              \"description\": \"Los muelles de madera crujen bajo el peso de los pasos y la carga. Barcos de diferentes tama\xC3\xB1os est\xC3\xA1n atracados\x2C algunos listos para partir hacia destinos desconocidos\x2C otros descargando sus mercanc\xC3\xADas. Marineros experimentados se preparan para surcar los mares\x2C sus miradas llenas de historias que solo el oc\xC3\xA9ano puede contar.\"\x2C\n              \"x\": 4\x2C\n              \"y\": 0\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"west\": \"harborEntrance\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"isBoatLocation\": true\x2C\n              \"connectedIslands\": [\n                \"dangerIsland\"\n              ]\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"captainNPC\"\n                }\n              ]\n            }\n          ]\n        }\n      ]\n    }\x2C\n    {\n      \"id\": \"dangerIsland\"\x2C\n      \"name\": \"Isla del Peligro\"\x2C\n      \"zones\": [\n        {\n          \"id\": \"pvpZone\"\x2C\n          \"name\": \"Tierras Salvajes\"\x2C\n          \"type\": \"pvp\"\x2C\n          \"rooms\": [\n            {\n              \"id\": \"dangerBeach\"\x2C\n              \"name\": \"Playa Peligrosa\"\x2C\n              \"description\": \"Las olas golpean con fuerza la orilla rocosa de esta playa hostil. El sonido del viento se mezcla con el romper de las olas\x2C creando una sinfon\xC3\xADa inquietante. Rocas afiladas se elevan como dientes que esperan a su presa. Aqu\xC3\xAD\x2C los visitantes deben estar siempre en guardia.\"\x2C\n              \"x\": 0\x2C\n              \"y\": 0\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"north\": \"darkForest\"\x2C\n                \"west\": \"crystalCave\"\x2C\n                \"south\": \"muddySwamp\"\n              }\x2C\n              \"isBoatLocation\": true\x2C\n              \"connectedIslands\": [\n                \"mainIsland\"\n              ]\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"beachWatcherNPC\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"darkForest\"\x2C\n              \"name\": \"Bosque Oscuro\"\x2C\n              \"description\": \"Un denso dosel de \xC3\xA1rboles cubre el cielo\x2C dejando pasar apenas un rayo de luz. Las sombras se mueven con una vida propia\x2C y el aire est\xC3\xA1 cargado con la sensaci\xC3\xB3n de ser observado. El silencio aqu\xC3\xAD es abrumador\x2C roto solo por el crujir ocasional de una rama o el aullido distante de una criatura.\"\x2C\n              \"x\": 0\x2C\n              \"y\": 1\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"south\": \"dangerBeach\"\x2C\n                \"east\": \"abandonedFort\"\x2C\n                \"west\": \"forgottenShrine\"\x2C\n                \"north\": \"ancientGraveyard\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"wolf\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"abandonedFort\"\x2C\n              \"name\": \"Fortaleza Abandonada\"\x2C\n              \"description\": \"Las ruinas de una antigua fortaleza se alzan en el horizonte\x2C los muros derrumbados y las torres partidas como testigos de un pasado turbulento. Las enredaderas cubren lo que queda de las paredes\x2C y el eco de pasos se siente como susurros de aquellos que alguna vez defendieron estas tierras. Un lugar perfecto para emboscadas y sorpresas desagradables.\"\x2C\n              \"x\": 1\x2C\n              \"y\": 1\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"west\": \"darkForest\"\x2C\n                \"south\": \"twistedThicket\"\x2C\n                \"east\": \"cliffsideOutpost\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"bandit\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"crystalCave\"\x2C\n              \"name\": \"Cueva de Cristales\"\x2C\n              \"description\": \"Una cueva subterr\xC3\xA1nea llena de cristales brillantes que reflejan la poca luz que se filtra desde la entrada. El suelo es resbaladizo por el agua que gotea desde las estalactitas\x2C y el eco de cada paso resuena como un recordatorio de que no est\xC3\xA1s solo.\"\x2C\n              \"x\": -1\x2C\n              \"y\": 0\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"east\": \"dangerBeach\"\x2C\n                \"north\": \"forgottenShrine\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"crystalGolem\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"forgottenShrine\"\x2C\n              \"name\": \"Santuario Olvidado\"\x2C\n              \"description\": \"Entre la densa maleza se esconde un antiguo santuario en ruinas. Las estatuas erosionadas parecen contar historias de tiempos antiguos. El aire aqu\xC3\xAD est\xC3\xA1 cargado con una energ\xC3\xADa misteriosa\x2C como si el lugar estuviera esperando ser descubierto de nuevo.\"\x2C\n              \"x\": -1\x2C\n              \"y\": 1\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"south\": \"crystalCave\"\x2C\n                \"east\": \"darkForest\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"npcs\": [\n                {\n                  \"id\": \"oldHermit\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"muddySwamp\"\x2C\n              \"name\": \"Pantano Fangoso\"\x2C\n              \"description\": \"Un terreno traicionero donde el barro profundo atrapa a los desprevenidos. Los mosquitos zumban sin cesar y la niebla espesa oculta lo que se esconde bajo la superficie. Aqu\xC3\xAD\x2C cada paso debe ser calculado.\"\x2C\n              \"x\": 0\x2C\n              \"y\": -1\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"north\": \"dangerBeach\"\x2C\n                \"west\": \"poisonMarsh\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"swampBeast\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"poisonMarsh\"\x2C\n              \"name\": \"Marisma Venenosa\"\x2C\n              \"description\": \"Las aguas estancadas emiten un hedor t\xC3\xB3xico\x2C y el aire es pesado y dif\xC3\xADcil de respirar. La vegetaci\xC3\xB3n es densa y retorcida\x2C con hongos venenosos que florecen en cada rinc\xC3\xB3n. Este lugar es mortal para cualquiera que no est\xC3\xA9 preparado.\"\x2C\n              \"x\": -1\x2C\n              \"y\": -1\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"east\": \"muddySwamp\"\x2C\n                \"north\": \"ancientGraveyard\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"marshSpirit\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"ancientGraveyard\"\x2C\n              \"name\": \"Cementerio Ancestral\"\x2C\n              \"description\": \"Las l\xC3\xA1pidas cubiertas de musgo y las tumbas abiertas cuentan historias de aquellos que perecieron hace mucho tiempo. Una neblina fantasmag\xC3\xB3rica se arrastra por el suelo\x2C y el aire se llena de un susurro inquietante de voces olvidadas.\"\x2C\n              \"x\": -1\x2C\n              \"y\": 0\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"south\": \"poisonMarsh\"\x2C\n                \"east\": \"darkForest\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"crystalGolem\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"sunkenTemple\"\x2C\n              \"name\": \"Templo Sumergido\"\x2C\n              \"description\": \"Los restos de un templo hundido se encuentran medio sumergidos en agua turbia. Columnas partidas y esculturas corro\xC3\xADdas sugieren una civilizaci\xC3\xB3n que una vez prosper\xC3\xB3 aqu\xC3\xAD. El agua oculta peligros y tesoros por igual.\"\x2C\n              \"x\": 1\x2C\n              \"y\": -1\x2C\n              \"z\": 0\x2C\n              \"exits\": {\n                \"north\": \"twistedThicket\"\x2C\n                \"west\": \"darkForest\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"crystalGolem\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"cliffsideOutpost\"\x2C\n              \"name\": \"Puesto de Avanzada en el Acantilado\"\x2C\n              \"description\": \"Situado al borde de un acantilado\x2C este peque\xC3\xB1o puesto de avanzada ofrece vistas espectaculares del oc\xC3\xA9ano\x2C pero tambi\xC3\xA9n est\xC3\xA1 expuesto a los vientos traicioneros. Los restos de antiguos campamentos sugieren que fue un punto estrat\xC3\xA9gico en tiempos de guerra.\"\x2C\n              \"x\": 2\x2C\n              \"y\": 1\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"west\": \"abandonedFort\"\x2C\n                \"south\": \"sunkenTemple\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"wolf\"\n                }\n              ]\n            }\x2C\n            {\n              \"id\": \"twistedThicket\"\x2C\n              \"name\": \"Matorral Retorcido\"\x2C\n              \"description\": \"Un espeso matorral de \xC3\xA1rboles y arbustos con ramas que parecen querer atraparte. Aqu\xC3\xAD\x2C el camino es oscuro y estrecho\x2C y los susurros del viento parecen palabras de advertencia.\"\x2C\n              \"x\": 1\x2C\n              \"y\": 0\x2C\n              \"z\": 1\x2C\n              \"exits\": {\n                \"north\": \"abandonedFort\"\n              }\x2C\n              \"corpses\": []\x2C\n              \"enemies\": [\n                {\n                  \"id\": \"goblin\"\n                }\n              ]\n            }\n          ]\n        }\n      ]\n    }\x2C\n    {\n      \"id\": \"astral\"\x2C\n      \"name\": \"Plano astral\"\x2C\n      \"zones\": [\n        {\n          \"id\": \"limboZone\"\x2C\n          \"name\": \"Terreno sin alma\"\x2C\n          \"rooms\": [\n            {\n              \"id\": \"deathZone\"\x2C\n              \"name\": \"Limbo\"\x2C\n              \"description\": \"Te encuentras en el Limbo\x2C un lugar donde el tiempo se disuelve y la realidad es difusa. No hay suelo bajo tus pies\x2C solo una niebla gris que se extiende en todas direcciones\x2C susurrando con voces lejanas y ecos de otros tiempos. La luz es tenue y sin fuente\x2C sumergi\xC3\xA9ndote en una penumbra interminable. Las sombras parecen moverse por voluntad propia\x2C mostrando destellos de lugares y rostros que se desvanecen al mirarlos. Aqu\xC3\xAD\x2C los esp\xC3\xADritus errantes deambulan\x2C atrapados en este reino entre la vida y la muerte\x2C mientras t\xC3\xBA esperas el juicio de los dioses\x2C aguardando el momento de tu retorno o tu destino final.\"\x2C\n              \"x\": 0\x2C\n              \"y\": 0\x2C\n              \"z\": 0\n            }\n          ]\x2C\n          \"exits\": {}\n        }\n      ]\n    }\x2C\n    {\n      \"id\": \"traveling\"\x2C\n      \"name\": \"viajando\"\x2C\n      \"zones\": [\n        {\n          \"id\": \"travelZone\"\x2C\n          \"name\": \"de viaje por el mundo\"\x2C\n          \"rooms\": [\n            {\n              \"id\": \"travelRoom\"\x2C\n              \"name\": \"Viajando\"\x2C\n              \"description\": \"que tu dise pibe\"\x2C\n              \"x\": 0\x2C\n              \"y\": 0\x2C\n              \"z\": 0\n            }\n          ]\x2C\n          \"exits\": {}\n        }\n      ]\n    }\n  ]\n}", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hashtag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageRightToLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScaleFactor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserTimeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_baseurl"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue="You have been disconnected from this application."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InterruptionMessage"
			Visible=true
			Group="Behavior"
			InitialValue="We are having trouble communicating with the server. Please wait a moment while we attempt to reconnect."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_LastMessageTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabOrderWrap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmDisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Platform"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDarkMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="WebSession.ColorModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Auto"
				"1 - Light"
				"2 - Dark"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserPrefersDarkMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SendEventsInBatches"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

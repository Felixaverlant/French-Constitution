request = require('request')
cheerio = require('cheerio')
fs = require('fs')

constitution_link = "http://www.legifrance.gouv.fr/affichTexte.do?cidTexte=LEGITEXT000006071194"

String::clean_strings = -> 
	@.replace /(\r\n|\n|\r|\t)/gm,""
String::trim = -> 
	@.replace /^\s+|\s+$/g, ""
String::reduce_spaces = ->
	@.replace /\s{2,}/g, " "
String::clean_trim = ->
	@.clean_strings().trim()
String::clean = ->
	@.clean_strings().trim().reduce_spaces()

Array::not_empty = ->
  if @.length > 0
  	return true
  else
  	return false

request constitution_link, (err,res,data) ->
	if !err && res.statusCode == 200
		
		$ 				 	= cheerio.load(data)
		
		json 			 	= {}
		json.title 		 	= $("div.enteteTexte > span:nth-child(5)").text().clean()
		json.introduction 	= $(".data > div > div:nth-child(2) > div:nth-child(1)").text().clean()
		json.articles 		= []

		$(".data > div > div > div > .article, .data > div > div > div > ul > li > .article").each ->
			article 		= {}
			$elem 			= $(@)
			
			# For the 2 first articles with no section_title
			if !$elem.parent().is("div")
				article.section = $elem.parent().find(".titreSection").text().clean()
				
			article.text = $elem.find("p").text().clean()
			
			# Split paragraphs - todo
			#txt 			= $elem.find("p").text().match(/(.*\n)/g)
			 
			if($elem.find(".titreArt a").attr("href"))
				article.see_more = "http://www.legifrance.gouv.fr/"+$elem.find(".titreArt a").attr("href")

			$(@).find(".titreArt a").remove()
			article.title 		  	= $(@).find(".titreArt").text().clean()
			article.index		 	= $(@).find(".titreArt").text().replace(/^\D+/g, '').clean()

			modified_by 				= []
			created_by 					= []

			$elem.find(".histoArt > ul > li").each ->
				if /Modifié/.test($(@).text())
					modified_by.push("http://www.legifrance.gouv.fr/"+$(@).find("a").attr("href"))
				if /Créé/.test($(@).text()) 
					created_by.push("http://www.legifrance.gouv.fr/"+$(@).find("a").attr("href"))

			if modified_by.not_empty()
				article.modified_by = modified_by
			if created_by.not_empty()
				article.created_by  = created_by 

			json.articles.push(article) 

		fs.writeFile 'constitution.json', JSON.stringify(json, null, 4), (err) ->
			console.log 'File successfully written - Check your project directory for the constitution.json file'
	else
		console.log "There was a problem ..."

		
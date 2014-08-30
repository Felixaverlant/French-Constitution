# French Constitution Json 
It seems that there's no json/structured version of the french constitution...
The DOM from the original URL is really a nightmare ...

## Code
Coffeescript
Libs :
- request
- cheerio

## Json structure

| name          | Desc                           | Type   | Mandatory  |
| ------------- |:------------------------------:| ------:| ----------:| 
| title         | Title of the document          | String | Yes        |
| introduction  | first sentence of the document | String | Yes        |
| articles      | List of articles               | Array  | Yes        |

### Article
| name            | Desc                                      | Type          | Mandatory  |
| --------------- |:-----------------------------------------:| -------------:| ----------:|
| index           | Article number                            | String        | Yes        |
| title           | Article name                              | String        | Yes        |
| see_more        | Link to more infos                        | String        | Yes        |
| section         | Section where the article is              | String        | No         |
| text            | content of the article                    | String        | Yes        |
| modified_by     | Link to the law that modified the article | Array[String] | No         |
| created_by      | Link to the law that created the article  | Array[String] | No         |

### Example
```json
{
    "title": "Constitution du 4 octobre 1958",
    "introduction": "Le Gouvernement de la République, conformément à la loi constitutionnelle du 3 juin 1958, a proposé, Le Peuple français a adopté, Le Président de la République promulgue la loi constitutionnelle dont la teneur suit :",
    "articles": [
        {
            "section": "Titre premier : De la souveraineté",
            "text": "Les partis et groupements politiques concourent à l'expression du suffrage. Ils se forment et exercent leur activité librement. Ils doivent respecter les principes de la souveraineté nationale et de la démocratie.Ils contribuent à la mise en oeuvre du principe énoncé au second alinéa de l'article 1er dans les conditions déterminées par la loi.La loi garantit les expressions pluralistes des opinions et la participation équitable des partis et groupements politiques à la vie démocratique de la Nation.",
            "see_more": "http://www.legifrance.gouv.fr/affichTexteArticle.do;jsessionid=AEF34CBC3F86C999C790EAA26201426D.tpdjo02v_2?idArticle=LEGIARTI000019240999&cidTexte=LEGITEXT000006071194&dateTexte=20140830",
            "title": "Article 4",
            "index": "4",
            "modified_by": [
                "http://www.legifrance.gouv.fr/affichTexteArticle.do;jsessionid=AEF34CBC3F86C999C790EAA26201426D.tpdjo02v_2?cidTexte=JORFTEXT000019237256&idArticle=LEGIARTI000019238674&dateTexte=20080724&categorieLien=id#LEGIARTI000019238674"
            ]
        }
    ]
}
```

## Todos
- [ ] Split contents by paragraphs
- [ ] Scrap other languages
- [ ] Do tests
- [ ] Get complet name for law that modified by
- [ ] Fork legifrance
- [ ] Deal with article that doesn't exist anymore
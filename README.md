#  Projet 10
## Les Bonus de Reciplease
### L'application Reciplease
Reciplease est une application de recherches de recettes de cuisine avec des outils indispensables pour chercher par ingrédient et mettre ces recettes en favoris.

**l'application se compose de plusieurs fonctionnalités principales :**
* le choix des ingrédients pour trouver des recettes correspondantes
* l'affichage du résultat des recherches
* la visualisation d'une recette précise
* la mise en favori des recettes choisis
* la visualisation des recettes mises en favori
* la persistence de données pour les favoris
### Les Bonus
**Plusieurs fonctionnalités bonus ont été rajoutées à l'application Reciplease :**

> 1. Le choix de paramètres pour la recherche de recettes
> 2. La persistence de données pour les paramètres
> 3. La suppression des ingrédients un par un
> 4. La recherche parmi les favoris d'une recette spécifique
> 5. La possibilité de mettre une recette en favori directement sur la page des résultats de la recherche

### Implémentation des Bonus

>> 1.  Le choix de paramètres pour la recherche de recettes

Afin de permettre l'ajout de paramètres pour la recherche de recettes tel que les régimes alimentaires, un type de cuisine ou signaler des alergies, nous allons créer un tableau en deux dimensions, afin de repérer chaque type de paramètres avec sa liste de choix possibles.

Pour créer ce tableau nous allons commencer par créer une structure *Parameter* qui aura plusieurs propriétés :
* Une constante de type *String* appelée : **title** qui représentera le titre de la catégorie de paramètre
* Une variable de type *Bool* appelée : **isExpanded** qui permettra d'afficher/masquer le contenu de la catégorie dans la tableView
* une variable de type *ListElement* appelée : **list** qui renverra à une *struct* elle même composée de deux variables, name et isSelected
```
    struct Parameter {
        var isExpanded: Bool
        let title: String
        var list: [ListElement]
    }
    struct ListElement {
        var name: String
        var isSelected: Bool
    }
```
Nous pouvons donc ainsi créer un tableau de type *Parameter* appelé **twoDimensionalArray**


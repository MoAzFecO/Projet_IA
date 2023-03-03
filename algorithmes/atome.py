import pandas as pd

def create_atom(chemin, sortie):
    données_data =pd.read_csv(chemin)  # chemin csv à lire
    données = données_data.values

    résultat = open(sortie,'w')  # nom du fichier lp à sauvegarder

    début_col = 8
    fin_col = len(données[0])
    nb_lignes = len(données)

    #atom(cellule, stage, gène, expression du gène).
    for i in range(0, nb_lignes):
        for j in range(début_col,fin_col):
                résultat.write("atom(" +
                    str(i) +", " +  # numéro de la cellule
                    str(données[i,2]).lower()+", " +  # stage de la cellule
                    données_data.columns[j].lower() +", " +  # nom du gène
                    str(données[i,j]) +").\n")  # expression du gène (0 ou 1)
                
def create_atom2(chemin, sortie): # pour l'algo ASP de Anran et Li
    données_data =pd.read_csv(chemin)  # chemin csv à lire
    données = données_data.values

    résultat = open(sortie,'w')  # nom du fichier lp à sauvegarder

    début_col = 8
    fin_col = len(données[0])
    nb_lignes = len(données)

    #atom(cellule, gène, expression du gène, stage)
    for i in range(0, nb_lignes):
        for j in range(début_col,fin_col):
                résultat.write("pert(" +
                    str(i) +", " +  # numéro de la cellule
                    données_data.columns[j].lower() +", " +  # nom du gène
                    str(données[i,j]) +", " + # expression du gène (0 ou 1)
                    str(données[i,2]).lower() +").\n")  # stage de la cellule


def lire_txt(matrice, chemin, sortie):
    f = open(chemin,"r")
    file = open(sortie+".txt", "w")
    texte = str(f.read())   
    x = texte.split()

    affinites = []
    genes = []

    # indice du dernier answer dans la sortie
    indice = 0
    for k, mot in enumerate(x) :
        if 'Answer' in mot :
            indice = k
    x = x[indice:] # on supprime le texte qui précède answer

    for mot in x:
        if 'affinite' in mot :
            affinites.append(mot[9:-1])
        if 'selec_gene' in mot :
            genes.append(mot[11:-1].upper())
   
    data_pd =pd.read_csv(f'données/{matrice}.csv')
    nom_cell = data_pd.values[:,0] # nom des cellules
    num_cell = []  # numéro des cellules
    for k in range(len(affinites)) : 
        affinite = affinites[k]
        split_aff = affinite.split(sep=',')
        num_cell.append(int(split_aff[0]))
        split_aff[0] = nom_cell[int(split_aff[0])]
        split_aff[1] = nom_cell[int(split_aff[1])]
        affinites[k] = str(tuple(split_aff))  # str(split_aff[0]) + ", " + str(split_aff[1])

    file.write("Les " + str(len(genes)) + " gènes sélectionnés sont : " + ', '.join(genes) + "\n" + 
        "Les " + str(len(affinites)) + " paires de cellules qui ont des affinités sont : " + ', '.join(affinites) + '\n')

    df = pd.DataFrame(columns=genes)
    for gene in genes : 
        column = data_pd[gene]
        for k, affinite in enumerate(affinites) :
            df.at[affinite[1:-1], gene] = column.iloc[num_cell[k]]
    print(df)
    df.to_csv(f"{sortie}.csv")

def lire_projection(chemin, nom_sortie):
    f = open(chemin, "r")
    texte = str(f.read())   
    x = texte.split()

    genes = {}
    for k, mot in enumerate(x):
        if 'selec_gene' in mot :
            nom_gene = mot[11:-1].upper()
            if nom_gene in genes:
                genes[nom_gene] += 1
            else :
                genes[nom_gene] = 1
        if 'Models' in mot:
            nb_modele = x[k+2]
    
    df = pd.DataFrame()
    df = df.from_dict([genes])
    df.insert(0, 'nombre_de_solutions', nb_modele)
    print(df)
    df.to_csv(nom_sortie + ".csv", index=False)

def lire_plusieurs_classes(matrice, chemin, sortie):
    f = open(chemin,"r")
    texte = str(f.read())   
    x = texte.split()

    num_match = []
    nom_match = []
    genes = []

    # indice du dernier answer dans la sortie
    indice = 0
    for k, mot in enumerate(x) :
        if 'Answer' in mot :
            indice = k
    x = x[indice:] # on supprime le texte qui précède answer

    for mot in x:
        if 'match' in mot :
            num_match.append(int(mot[6:-1]))
        if 'selec_gene' in mot :
            genes.append(mot[11:-1].upper())
   
    data_pd =pd.read_csv(f'données/{matrice}.csv')
    nom_cell = data_pd.values[:,0] # nom des cellules
    for numero in num_match: 
        nom_match.append(nom_cell[numero])

    df = pd.DataFrame(columns=genes)
    for gene in genes : 
        column = data_pd[gene]
        for k, match in enumerate(nom_match) :
            df.at[match, gene] = column.iloc[num_match[k]]
    print(df)
    df.to_csv(f"{sortie}.csv")

def create_all_atom():
    create_atom("matrices/B.csv", "données/B.lp")
    create_atom("matrices/C.csv", "données/C.lp")
    create_atom("matrices/D.csv", "données/D.lp")
    create_atom("matrices/B_3_classes.csv", "données/B_3_classes.lp")
    create_atom("matrices/C_3_classes.csv", "données/C_3_classes.lp")
    create_atom("matrices/D_3_classes.csv", "données/D_3_classes.lp")
    create_atom("matrices/B_4_classes.csv", "données/B_4_classes.lp")
    create_atom("matrices/C_4_classes.csv", "données/C_4_classes.lp")
    create_atom("matrices/D_4_classes.csv", "données/D_4_classes.lp")
    create_atom2("matrices/B.csv", "données/anran_li/B.lp")
    create_atom2("matrices/B.csv", "données/anran_li/C.lp")
    create_atom2("matrices/B.csv", "données/anran_li/D.lp")

if __name__ == "__main__" :
    #create_all_atom()
    #lire_txt("B", "test0.txt", "sortie3")
    #lire_projection("projection.txt", 'projection')
    #lire_plusieurs_classes("B_3_classes", "B_3_classes.txt", "B_3_classes_k=4")
    #lire_projection("projection_3_classes.txt", 'projection_3_classes')
    pass
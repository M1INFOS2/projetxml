<?xml version="1.0" encoding="utf-8" ?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:output method="html" encoding="iso-8859-1"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<xsl:template match="/master">
		<xsl:document href="www/index.html">
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
				</head>
				<body>
					<xsl:call-template name="liste-personnes-nom" />
					<xsl:call-template name="liste-matières-nom" />
					<xsl:call-template name="liste-spécialités-nom" />
				</body>
			</html>
		</xsl:document>

		<xsl:call-template name="liste-personnes" />
		<xsl:call-template name="liste-matières" />
		<xsl:call-template name="liste-spécialités" />
		<xsl:call-template name="liste-parcours" />
	</xsl:template>

	<xsl:template name="liste-personnes-nom">
		<h2>Intervenants</h2>
		<ul>
			<xsl:for-each select="personnes/personne">
				<li>
					<a href="personne-{@id}.html#{@id}">
						<xsl:value-of select="nom" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
		<br />
	</xsl:template>

	<xsl:template name="liste-matières-nom">
		<h2>Matières</h2>
		<ul>
			<xsl:for-each select="matières/matière">
				<li>
					<a href="matiere-{@id}.html#{@id}">
						<xsl:value-of select="nom" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
		<br />
	</xsl:template>

	<xsl:template name="liste-spécialités-nom">
		<h2>Spécialités et parcours</h2>
		<table border="1" bgcolor="#CCC" cellspacing="3px">
			<tr>
				<th>Années</th>
				<th>Spécialité</th>
				<th>Parcours</th>
			</tr>
			<xsl:for-each select="spécialités/spécialité">
				<tr>
					<td>
						<xsl:value-of select="@année" />
					</td>
					<td>
						<xsl:if test="not(nom = ./parcours/nom)">
							<a href="specialite-{code}.html#{code}">
								<xsl:value-of select="nom" />
							</a>
						</xsl:if>
						<xsl:if test="(nom = ./parcours/nom)">
							<a href="parcours-{code}.html#{code}">
								<xsl:value-of select="nom" />
							</a>
						</xsl:if>
					</td>
					<td>
						<xsl:if test="not(nom = ./parcours/nom)">
							<xsl:for-each select="parcours">
								<table border="3" bgcolor="#CCC" cellspacing="3px">					<!-- à revoir... -->
									<a href="parcours-{code}.html#{code}">
										<xsl:value-of select="nom" />
									</a>
								</table>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="liste-personnes">

		<xsl:for-each select="personnes/personne">
			<xsl:document href="www/personne-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
					</head>
					<body>
						<h2 align="center">
							<xsl:value-of select="nom" />
						</h2>
						<table border="1" bgcolor="#CCC" cellspacing="3px">
							<tr>
								<th>Nom</th>
								<th>Etablissement</th>
								<th>email</th>
							</tr>
							<tr id="{@id}">
								<td>
									<xsl:value-of select="nom" />
								</td>
								<td>
									<xsl:value-of select="établissement" />
								</td>
								<td>
									<xsl:value-of select="email" />
								</td>
							</tr>
						</table>

						<xsl:variable name="nom_p">
							<xsl:value-of select="@id" />
						</xsl:variable>
						<h2 align="center">Matières enseignées</h2>
						<ul>
							<xsl:for-each
								select="../../matières/matière[ref-intervenant/@ref = $nom_p]">
								<li>
									<a href="matiere-{@id}.html#{@id}">
										<xsl:value-of select="nom" />
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="liste-matières">
		<xsl:for-each select="matières/matière">
			<xsl:document href="www/matiere-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
					</head>
					<body>
						<table border="1" bgcolor="#CCC" cellspacing="3px">
							<tr>
								<th>Nom</th>
								<th>résumé</th>
								<th>crédits</th>
								<th>intervenant</th>
								<th>horaires</th>
							</tr>
							<tr id="{@id}">
								<td>
									<xsl:value-of select="nom" />
								</td>
								<td>
									<xsl:value-of select="résumé" />
								</td>
								<td align="right">
									<xsl:value-of select="crédits" />
								</td>
								<td>

									<xsl:for-each select="ref-intervenant">
										<xsl:variable name="nom_p">
											<xsl:value-of select="@ref" />
										</xsl:variable>
										<table border="3" bgcolor="#CCC" cellspacing="3px">	 <!-- à revoir... -->
											<a href="personne-{@ref}.html#{@ref}">
												<xsl:value-of select="/master/personnes/personne[@id =$nom_p]/nom" />
											</a>
										</table>
									</xsl:for-each>
								</td>
								<td>
									<xsl:value-of select="horaire_c_td_tp" />
								</td>
							</tr>
						</table>
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="liste-spécialités">
		<xsl:for-each select="spécialités/spécialité">
			<xsl:document href="www/specialite-{code}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
					</head>
					<body>
						<table border="1" bgcolor="#CCC" cellspacing="3px">
							<tr>
								<th>Nom</th>
								<th>Code</th>
								<th>Finalité</th>
								<th>Lieu</th>
								<th>Responsable</th>
								<th>Descritption</th>
								<th>Parcours</th>
							</tr>
							<tr id="{code}">
								<td>
									<xsl:value-of select="nom" />
								</td>
								<td>
									<xsl:value-of select="code" />
								</td>
								<td>
									<xsl:value-of select="finalité" />
								</td>
								<td>
									<xsl:value-of select="lieu" /> <!-- foreach -->
								</td>
								<td>
									<xsl:for-each select="ref-responsable">
										<table border="3" bgcolor="#CCC" cellspacing="3px">	 <!-- à revoir... -->
											<a href="personne-{@ref}.html#{@ref}">
												<xsl:value-of select="@ref" />
											</a>
										</table>
									</xsl:for-each>
								</td>
								<td>
									<xsl:value-of select="description" />
								</td>
								<td>
									<xsl:for-each select="parcours">
										<table border="3" bgcolor="#CCC" cellspacing="3px">	 <!-- à revoir... -->
											<a href="parcours-{code}.html#{code}">
												<xsl:value-of select="nom" />
											</a>
										</table>
									</xsl:for-each>
								</td>
							</tr>
						</table>
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="liste-parcours">
		<xsl:for-each select="spécialités/spécialité/parcours">
			<xsl:document href="www/parcours-{code}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
					</head>
					<body>
						<table border="1" bgcolor="#CCC" cellspacing="3px">
							<tr>
								<th>Nom</th>
								<th>Code</th>
								<th>Responsable</th>
								<th>Lieu</th>
							</tr>
							<tr id="{code}">
								<td>
									<xsl:value-of select="nom" />
								</td>
								<td>
									<xsl:value-of select="code" />
								</td>
								<td>
									<xsl:for-each select="ref-responsable">
										<table border="3" bgcolor="#CCC" cellspacing="3px">	 <!-- à revoir... -->
											<a href="personne-{@ref}.html#{@ref}">
												<xsl:value-of select="@ref" />
											</a>
										</table>
									</xsl:for-each>
								</td>
								<td>
									<xsl:value-of select="lieu" /> <!-- foreach -->
								</td>
							</tr>
						</table>
						<br />
						<h2>Présentation</h2>
						<p>
							<xsl:value-of select="présentation" />
						</p>
						<br />


						<h2>Programme des enseignements</h2>

						<xsl:for-each select="programme">
							<h3>
								Programme du semestre
								<xsl:value-of select="@semestre" />
							</h3>
							<table border="3" bgcolor="#CCC" cellspacing="3px">	 <!-- à revoir... -->
								<tr>
									<th>Matières</th>
								</tr>
								<xsl:for-each select="ref-matière">
									<tr>
										<td>
											<xsl:variable name="nom_m">
												<xsl:value-of select="@ref" />
											</xsl:variable>
											<xsl:value-of
												select="../../../../../matières/matière[@id = $nom_m]/nom" />
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</xsl:for-each>

					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

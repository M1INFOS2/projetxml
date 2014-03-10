<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="html" encoding="utf-8"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
              doctype-public="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

  <xsl:template match="/master">

    <xsl:document href="www/index.html">
      <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
      <html>
        <xsl:call-template name="head" />
        <body>
          <xsl:call-template name="menu" />
          <xsl:call-template name="liste-personnes-nom" />
          <xsl:call-template name="liste-matières-nom" />
          <xsl:call-template name="liste-spécialités-nom" />
        </body>
      </html>
    </xsl:document>

    <xsl:document href="www/personnes.html">
      <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
      <html>
        <xsl:call-template name="head" />
        <body>
          <xsl:call-template name="menu" />
          <xsl:call-template name="liste-personnes-nom" />
        </body>
      </html>
    </xsl:document>

    <xsl:document href="www/matieres.html">
      <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
      <html>
        <xsl:call-template name="head" />
        <body>
          <xsl:call-template name="menu" />
          <xsl:call-template name="liste-matières-nom" />
        </body>
      </html>
    </xsl:document>

    <xsl:call-template name="liste-personnes" />
    <xsl:call-template name="liste-matières" />
    <xsl:call-template name="liste-spécialités" />
    <xsl:call-template name="liste-parcours" />
  </xsl:template>

  <xsl:template name="head">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
      <link rel="stylesheet" type="text/css" href="mon_style.css" />
    </head>
  </xsl:template>

  <xsl:template name="menu">
    <table class="menu">
      <tr>
        <td>
          <a class="menu" href="index.html">Accueil</a>
        </td>
        <td>
          <a class="menu" href="personnes.html">Intervenants</a>
        </td>
        <td>
          <a class="menu" href="matieres.html">Matières</a>
        </td>
      </tr>
    </table>
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
  </xsl:template>

  <xsl:template name="liste-spécialités-nom">
    <h2>Spécialités et parcours</h2>
    <table>
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
                  <a href="parcours-{code}.html#{code}">
                    <xsl:value-of select="nom" />
                  </a>
                  <br />
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
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
        <html>
          <xsl:call-template name="head" />
          <body>
            <xsl:call-template name="menu" />
            <h1>
              <xsl:value-of select="nom" />
            </h1>
            <table>
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
            <h2>Matières enseignées</h2>
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

            <h2>Parcours</h2>
            <xsl:if
                test="not(../../spécialités/spécialité/parcours[ref-responsable/@ref = $nom_p])">
              Aucun parcours.
            </xsl:if>
            <ul>
              <xsl:for-each
                  select="../../spécialités/spécialité/parcours[ref-responsable/@ref = $nom_p]">
                <li>
                  <a href="parcours-{code}.html#{code}">
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
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
        <html>
          <xsl:call-template name="head" />

          <body>
            <xsl:call-template name="menu" />
            <xsl:variable name="nom_m">
              <xsl:value-of select="@id" />
            </xsl:variable>
            <h1>
              <xsl:value-of select="nom" />
            </h1>
            <table>
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
                    <table>
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
            <h3> Cette matière apparaît dans les parcours :</h3>
            <ul>
              <xsl:for-each select="../../spécialités/spécialité/parcours">
                <xsl:variable name="code_p">
                  <xsl:value-of select="code" />
                </xsl:variable>
                <xsl:for-each select="programme/ref-matière[@ref=$nom_m]">
                  <li>
                    <a href="parcours-{$code_p}.html#{$code_p}">
                      <xsl:value-of select="../../nom" />
                    </a>
                  </li>
                </xsl:for-each>
              </xsl:for-each>
            </ul>
          </body>
        </html>
      </xsl:document>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="liste-spécialités">
    <xsl:for-each select="spécialités/spécialité">
      <xsl:document href="www/specialite-{code}.html">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
        <html>
          <xsl:call-template name="head" />
          <body>
            <xsl:call-template name="menu" />
            <h1><xsl:value-of select="nom" /></h1>
            <table>
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
                  <xsl:value-of select="lieu" />
                </td>
                <td>
                  <xsl:for-each select="ref-responsable">
                    <table>
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
                    <table>
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
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
        <html>
          <xsl:call-template name="head" />
          <body>
            <xsl:call-template name="menu" />
            <h1>
              <xsl:value-of select="nom" />
            </h1>
            <table>
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
                    <table>
                      <a href="personne-{@ref}.html#{@ref}">
                        <xsl:value-of select="@ref" />
                      </a>
                    </table>
                  </xsl:for-each>
                </td>
                <td>
                  <xsl:value-of select="lieu" />
                </td>
              </tr>
            </table>
            <h2>Présentation</h2>
            <p>
              <xsl:value-of select="présentation" />
            </p>
            <h2>Programme des enseignements</h2>
            <xsl:for-each select="programme">
              <h3>
                Programme du semestre
                <xsl:value-of select="@semestre" />
              </h3>
              <table>	 
                <tr>
                  <th>Matières</th>
                </tr>
                <xsl:for-each select="ref-matière">
                  <tr>
                    <td>
                      <xsl:variable name="nom_m">
                        <xsl:value-of select="@ref" />
                      </xsl:variable>
                      <a href="matiere-{$nom_m}.html#{$nom_m}">
                        <xsl:value-of
                            select="../../../../../matières/matière[@id = $nom_m]/nom" />
                      </a>
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

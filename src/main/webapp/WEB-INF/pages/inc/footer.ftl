			</div>
			</div>
			</section>
			<footer class="page-footer">
  <div class="footer-top">
    <ul>
      <li>IPT <@s.text name="footer.version"/> ${cfg.version!"???"}</li>
      <li><a href="http://www.gbif.org/ipt"><@s.text name="footer.projectHome"/></a></li>
      <li><a href="https://github.com/gbif/ipt/wiki/IPT2ManualNotes_ES.wiki" target="_blank"><@s.text name="footer.useManual"/></a></li>
      <li><a href="https://github.com/SIB-Colombia/ipt/issues/new" target="_blank"><@s.text name="footer.bugReport"/></a></li>
      <li><a href="https://github.com/SIB-Colombia/ipt/issues/new" target="_blank"><@s.text name="footer.featureRequest"/></a></li>
    </ul>
  </div>
  <div class="footer-bottom clearfix">
    <div class="footer-right">
    <stong>SEDE PRINCIPAL</stong><br>
Calle 28A No. 15-09 Bogotá D.C., Colombia.<br>
Telefono PBX 57(1) 320 2767<br>
<a href="mailto:sib@humboldt.org.co">sib@humboldt.org.co</a>
    </div>
    <div class="footer-left">
      <img src="${baseURL}/images/sib-logo-full.svg" width="350" alt="SIB">
    </div>
  </div>
</footer>		
		</div>

    <div id="modalbox"><div id="modalback"></div><div id="modalcontainer"><div id="modalcontent"></div></div></div>
    <script>
    if (!Modernizr.svgasimg) {
      $('img[src$=".svg"]').each(function() {
          //Replaces 'logo.svg' with 'logo.png'.
          $(this).attr('src', $(this).attr('src').replace('.svg', '.png'));
      });
    }
    </script>
	</body>
</html>
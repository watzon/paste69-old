class Home::PrivacyPolicyPage < MainLayout
  def page_title
    "Privacy Policy"
  end

  def content
    div class: "flex flex-col h-screen justify-between" do
      mount Shared::Navbar
      div class: "w-full flex-grow text-gray-800 bg-gray-200 dark:bg-gray-700 dark:text-gray-200" do
        div class: "container mx-auto py-12" do
          h2 "Privacy Policy", class: "font-bold text-4xl mb-4"

          h4 "Last updated: 27/05/2023", class: "text-lg mb-6"

          para "Paste69 ('we', 'us', or 'our') operates the 0x45.st website (the 'Service'). Your privacy is important to us, and this Privacy Policy outlines the types of personal information we collect, how we use it, and the steps we take to protect your privacy.", class: "mb-2 mt-2"

          para "By using the Service, you agree to the collection and use of information in accordance with this policy.", class: "mb-2 mt-2"

          h3 "Information Collection and Use", class: "font-bold text-xl mt-4 mb-2"

          para "We are committed to respecting your privacy and do not collect any personal information from users of our Service. The only information we collect is related to the pastes you create on the website. These pastes may be deleted at any time and are not stored on a fixed schedule.", class: "mb-2 mt-2"

          h3 "Local Storage", class: "font-bold text-xl mt-4 mb-2"

          para "We use local storage to save your theme preferences. Local storage is a web storage method that allows websites to store data in your browser for an extended period of time. This data is not shared with third parties, and we do not use it to track your usage of our Service.", class: "mb-2 mt-2"

          h3 "Cookies", class: "font-bold text-xl mt-4 mb-2"

          para "Our Service does not use cookies. A cookie is a small file that is stored on your device to help websites remember information about you. As we do not collect any personal information or track user behavior, cookies are not required or used on our website.", class: "mb-2 mt-2"

          h3 "Service Providers", class: "font-bold text-xl mt-4 mb-2"

          para "We may employ third-party companies and individuals to facilitate our Service, to provide the Service on our behalf, or to perform Service-related services. These third parties have access to your pastes only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.", class: "mb-2 mt-2"

          h3 "Security", class: "font-bold text-xl mt-4 mb-2"

          para "The security of your data is important to us, but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your pastes, we cannot guarantee their absolute security.", class: "mb-2 mt-2"

          h3 "Links to Other Sites", class: "font-bold text-xl mt-4 mb-2"

          para "Our Service may contain links to other sites that are not operated by us. If you click on a third-party link, you will be directed to that third party's site. We strongly advise you to review the Privacy Policy of every site you visit.", class: "mb-2 mt-2"

          para "We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.", class: "mb-2 mt-2"

          h3 "Data Retention", class: "font-bold text-xl mt-4 mb-2"

          para "As mentioned earlier, we do not collect any personal information. The pastes you create on our website are stored on our servers and may be deleted at any time without notice. We do not maintain a fixed schedule for the deletion of pastes. You are advised to keep a backup of your pastes if you wish to retain them for a longer period.", class: "mb-2 mt-2"

          h3 "Children's Privacy", class: "font-bold text-xl mt-4 mb-2"

          para "Our Service does not address anyone under the age of 13 ('Children'). We do not knowingly collect personally identifiable information from children under 13. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us. If we discover that a child under 13 has provided us with personal information, we will promptly delete such information from our servers.", class: "mb-2 mt-2"

          h3 "International Users", class: "font-bold text-xl mt-4 mb-2"

          para "Our Service is intended for use by individuals in the United States. If you access the Service from outside the United States, be aware that your information may be transferred to, stored, and processed in the United States where our servers are located. By using the Service, you consent to the transfer, storage, and processing of your information in the United States.", class: "mb-2 mt-2"

          h3 "Your Consent", class: "font-bold text-xl mt-4 mb-2"

          para "By using our Service, you consent to our Privacy Policy and agree to its terms.", class: "mb-2 mt-2"

          h3 "Governing Law", class: "font-bold text-xl mt-4 mb-2"

          para "This Privacy Policy and any disputes relating thereto shall be governed by and construed in accordance with the laws of [Your State, Province, or Country], without regard to its conflict of law provisions.", class: "mb-2 mt-2"

          h3 "Changes to This Privacy Policy", class: "font-bold text-xl mt-4 mb-2"

          para "We reserve the right to modify this Privacy Policy at any time. We encourage you to review this Privacy Policy regularly to stay informed about our information practices and your privacy options. Your continued use of the Service after any modification to this Privacy Policy will constitute your acceptance of such modifications.", class: "mb-2 mt-2"

          h3 "Contact Us", class: "font-bold text-xl mt-4 mb-2"

          para "If you have any questions about this Privacy Policy, please contact us by email: support (at) 0x45.st.", class: "mb-2 mt-2"

          para "We are committed to safeguarding your privacy and ensuring that your use of our Service is a positive experience.", class: "mb-2 mt-6"
        end
      end
      mount Shared::Footer
    end
  end
end

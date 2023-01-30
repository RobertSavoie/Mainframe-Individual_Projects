       identification division.
       program-id. A2_ItemList.
       author. Rob Savoie.
       date-written. Jan 29/2023.
      *
       environment division.
       configuration section.
       input-output section.
      *
       file-control.
      *
      *input-file declaration
      *
           select input-file
               assign to "../../../data/A2-ItemList.dat"
               organization is line sequential.
      *        
      *output-file declaration
      *
           select output-file
               assign to "../../../data/A2-ItemList.out"
               organization is line sequential.
      *
       data division.
       file section.
      *
       fd input-file
           data record is input-line
           record contains 27 characters.
      *
       01 input-line.
           05 il-item-number           pic 9(4).
           05 il-product-class         pic x.
           05 il-desc                  pic x(13).
           05 il-qty                   pic 999.
           05 il-price-per-unit        pic 9(4)v99.
      *
       fd output-file
           data record is output-line
           record contains 172 characters.
      *
       01 output-line                  pic x(172) value spaces.
      *
       working-storage section.
      *
       01 ws-flags.
           05 ws-eof-flag              pic x value "n".
           05 ws-eof-yes               pic x value "y".
           05 ws-eof-no                pic x value "n".
           05 ws-eof-other             pic x value "x".
      *
       01 ws-name.
           05 filler                   pic x(161).
           05 filler                   pic x(14) value "ROB SAVOIE, A2".
      *
       01 ws-heading.
           05 ws-head-one              pic x(11) value "Item Number".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-two              pic x(11) value "Description".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-three            pic xxx value "Qty".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-four             pic x(14) value "Price Per Unit".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-five             pic x(14) value "Extended Price".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-six              pic x(15) value
                                       "Discount Amount".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-seven            pic x(9) value "Net Price".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-eight            pic x(13) value "Product Class".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-nine             pic x(16) value
                                       "Transportation %".
           05 filler                   pic x(5) value "  |  ".
           05 ws-head-ten              pic x(21) value
                                       "Transportation Charge".
      *
       01 ws-general.
           05 filler                   pic xxx value spaces.
           05 ws-item-number           pic x(11).
           05 filler                   pic x(2) value spaces.
           05 ws-desc                  pic x(11).
           05 filler                   pic x(5) value spaces.
           05 ws-qty                   pic zzz.
           05 filler                   pic x(8) value spaces.
           05 ws-price-per-unit        pic z,zzz,zz9.99.
           05 filler                   pic x(5) value spaces.
           05 ws-ext-price             pic z,zzz,zz9.99.
           05 filler                   pic x(5) value spaces.
           05 ws-discount              pic 9(15).
           05 filler                   pic x(5) value spaces.
           05 ws-net-price             pic 9(9).
           05 filler                   pic x(12) value spaces.
           05 ws-product-class         pic x(13).
           05 filler                   pic x(2) value spaces.
           05 ws-trans-percent         pic 9(16).
           05 filler                   pic x(5) value spaces.
           05 ws--trans-charge         pic 9(18).
      *
       01 ws-summary.
           05 filler                   pic xxx value spaces.
      *
       01 ws-discount-analysis.
           05 filler                   pic xxx value spaces.
      *
       01 ws-cnsts.
           05 ws-discount-a            pic 9.999 value 1.125.
           05 ws-discount-d            pic 9.99 value 1.85.
           05 ws-discount-f            pic 9.99 value 1.45.
           05 ws-trans-percent         pic 9.99 value 1.65.
           05 ws-trans-cost            pic 99 value 45.
           05 ws-class-A               pic x value "A".
           05 ws-class-B               pic x value "B".
           05 ws-class-F               pic x value "F".
      *
       procedure division.
      *
       000-main.
      *
           open input input-file.
           open output output-file.
      *
           write output-line from ws-name.
           write output-line from ws-heading
               before advancing 3 lines.
      *
           read input-file
               at end
                   move ws-eof-yes to ws-eof-flag.
      *
           perform 100-process-file
               until ws-eof-flag equals ws-eof-yes.
      *
           goback.
      *
       100-process-file.
      *
      *clear output buffer
      *
           move spaces to output-line.
      *
      *move detail output data
      *
           move il-item-number     to ws-item-number.
           move il-desc            to ws-desc.
           move il-qty             to ws-qty.
           move il-price-per-unit  to ws-price-per-unit.
           move il-price-per-unit  to ws-price-per-unit.
           move il-product-class   to ws-product-class.
      *
      *extended price
      *
           multiply il-qty
                 by il-price-per-unit
             giving ws-ext-price.
      *
      *write detail output
      *
           write output-line from ws-general
               before advancing 2 lines.
      *
      *read next record from input-file
      *
           read input-file
               at end
                   move ws-eof-yes to ws-eof-flag.
      *
       end program A2_ItemList.